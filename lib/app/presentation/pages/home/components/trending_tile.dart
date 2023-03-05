import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/media/media.dart';
import '../../../utils/get_image_url.dart';

class TrendingTile extends StatelessWidget {
  const TrendingTile({super.key, required this.media, required this.width});
  final Media media;
  final double width;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: width,
        child: Stack(
          children: [
            Positioned.fill(
              child: ExtendedImage.network(
                getImageURL(media.posterPath!),
                loadStateChanged: (state) {
                  if (state.extendedImageLoadState == LoadState.loading) {
                    return Container(
                      color: Colors.black12,
                    );
                  }
                  return state.completedWidget;
                },
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: Opacity(
                opacity: 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      label: Text(
                        media.voteAverage!.toStringAsFixed(1),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      label: Icon(
                        media.mediaType == MediaType.movie
                            ? Icons.movie
                            : Icons.tv,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
