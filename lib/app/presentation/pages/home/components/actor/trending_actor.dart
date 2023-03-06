import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/either/either.dart';
import '../../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../../domain/models/actors/actors.dart';
import '../../../../../domain/repositories/trending_repository.dart';
import 'actor_tile.dart';

class TrendingActor extends StatefulWidget {
  const TrendingActor({super.key});

  @override
  State<TrendingActor> createState() => _TrendingActorState();
}

class _TrendingActorState extends State<TrendingActor> {
  late Future<Either<HttpRequestFailure, List<Actor>>> _future;
  late PageController _pageController;

  // int _currentCard = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
    _pageController = PageController(initialPage: 1);

    // _pageController.addListener(() {
    //   _currentCard = _pageController.page!.toInt();
    //   setState(() {});
    // });

    _future = context.read<TrendingRepository>().getActors();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: FutureBuilder<Either<HttpRequestFailure, List<Actor>>>(
        // future: context.read<TrendingRepository>().getActors(),
        future: _future,
        builder: (_, snapshot) {
          //

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final response = snapshot.data;
          print(response);

          return response!.when(
            left: (failure) {
              return const Text('error');
            },
            right: (actors) => Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    // *PADENDS PARA ALINEAR A LA IZQUIERDA
                    padEnds: false,
                    itemBuilder: (context, index) {
                      final actor = actors[index];
                      return ActorTile(
                        actor: actor,
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: actors.length,
                  ),
                ),
                // Text('${_currentCard + 1}/${actors.length}'),

                AnimatedBuilder(
                  animation: _pageController,
                  builder: (_, __) {
                    final int currentCard = _pageController.page?.toInt() ?? 1;
                    return Text('${currentCard + 1}/${actors.length}');
                  },
                ),

                const SizedBox(height: 15),
              ],
            ),
          );
        },
      ),
    );
  }
}
