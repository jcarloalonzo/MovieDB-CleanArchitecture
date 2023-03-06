import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/actors/actors.dart';
import '../../../../utils/get_image_url.dart';
import '../movies/trending_tile.dart';

class ActorTile extends StatelessWidget {
  const ActorTile({super.key, required this.actor});

  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: ExtendedImage.network(
                getImageURL(actor.profilePath!),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(15).copyWith(
                  bottom: 40,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      actor.name ?? actor.originalName ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (actor.knownFor.isNotEmpty)
                      // SizedBox(
                      //   height: 110,
                      //   child: ListView.separated(
                      //     separatorBuilder: (_, __) {
                      //       return const SizedBox(width: 15);
                      //     },
                      //     scrollDirection: Axis.horizontal,
                      //     itemBuilder: (_, index) {
                      //       final media = actor.knownFor[index];
                      //       return TrendingTile(
                      //         media: media,
                      //         width: 120 * 0.75,
                      //         showData: false,
                      //       );
                      //     },
                      //     itemCount: actor.knownFor.length,
                      //   ),
                      // )
                      SizedBox(
                        height: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: actor.knownFor
                              .take(3)
                              .map(
                                (media) => TrendingTile(
                                  media: media,
                                  width: 120 * 0.75,
                                  showData: false,
                                ),
                              )
                              .toList(),
                        ),
                      )

                    //
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
