import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/get_image_url.dart';
import '../movie_state.dart';

class MovieContent extends StatelessWidget {
  const MovieContent({super.key, required this.state});
  final MovieStateLoaded state;

  @override
  Widget build(BuildContext context) {
    final movie = state.movie;
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 13,
          child: ExtendedImage.network(
            getImageURL(movie.backdropPath,
                imageQuality: ImageQuality.original),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
