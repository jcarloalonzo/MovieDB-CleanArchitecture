import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../global/widgets/request_failed.dart';
import '../../home_controller.dart';
import 'actor_tile.dart';

class TrendingActor extends StatefulWidget {
  const TrendingActor({super.key});

  @override
  State<TrendingActor> createState() => _TrendingActorState();
}

class _TrendingActorState extends State<TrendingActor> {
  final _pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeController>();
    final state = bloc.state;
    return Expanded(
      child: state.when(loading: (_) {
        return const Center(child: CircularProgressIndicator());
        //
      }, failed: (_) {
        return RequestFailed(onRetry: () {});
      }, loaded: (_, __, actors) {
        //

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
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
            // Text('${_currentCard + 1}/${actors.length}'),

            Positioned(
              bottom: 30,
              child: AnimatedBuilder(
                animation: _pageController,
                builder: (_, __) {
                  final int currentCard = _pageController.page?.toInt() ?? 0;
                  return Row(
                    children: List.generate(
                      actors.length,
                      (index) => Icon(
                        Icons.circle,
                        size: 14,
                        color:
                            currentCard == index ? Colors.blue : Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),
          ],
        );
      }),
    );
  }
}
