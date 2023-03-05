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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = context.read<TrendingRepository>().getActors();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: FutureBuilder<Either<HttpRequestFailure, List<Actor>>>(
        future: context.read<TrendingRepository>().getActors(),
        // future: _future,
        builder: (_, snapshot) {
          //

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final response = snapshot.data;
          print(response);

          return response!.when(left: (failure) {
            return const Text('error');
          }, right: (actors) {
            // return PageView(
            //   scrollDirection: Axis.horizontal,
            //   children: actors.map((actor) {
            //     return SizedBox(
            //       width: width,
            //       child: Padding(
            //         padding: const EdgeInsets.all(15.0),
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.circular(20),
            //           child: Stack(
            //             children: [
            //               Positioned.fill(
            //                 child: ExtendedImage.network(
            //                   getImageURL(actor.profilePath!),
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   }).toList(),
            // );

            return PageView.builder(
              itemBuilder: (context, index) {
                final actor = actors[index];
                return ActorTile(
                  actor: actor,
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: actors.length,
            );
          });
        },
      ),
    );
  }
}
