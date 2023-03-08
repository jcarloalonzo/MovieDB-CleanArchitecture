import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/movies_repository.dart';
import '../movie_state.dart';
import 'movie_cast.dart';
import 'movie_header.dart';

class MovieContent extends StatelessWidget {
  const MovieContent({super.key, required this.state});
  final MovieStateLoaded state;

  @override
  Widget build(BuildContext context) {
    final movie = state.movie;
    return Column(
      children: [
        MovieHeader(
          movie: movie,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            movie.overview ?? '',
          ),
        ),
        MovieCast(movieID: movie.id),
        ElevatedButton(
          onPressed: () async {
            final bloc =
                context.read<MoviesRepository>().getCastByMovie(768362);
            print(bloc);
          },
          child: const Text('m'),
        ),
      ],
    );
  }
}
