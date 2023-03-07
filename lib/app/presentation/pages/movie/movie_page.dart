import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/repositories/movies_repository.dart';
import '../../global/widgets/request_failed.dart';
import 'movie_controller.dart';
import 'movie_state.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key, required this.movieID});

  final int movieID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieController(
        MovieState.loading(),
        moviesRepository: context.read<MoviesRepository>(),
        movieID: movieID,
      )..init(),
      builder: (context, _) {
        final bloc = context.watch<MovieController>();
        return Scaffold(
          appBar: AppBar(
              //
              ),
          body: bloc.state.when(
            loading: () {
              return const Center(child: CircularProgressIndicator());

              //
            },
            failed: () {
              return RequestFailed(
                onRetry: () {
                  //
                },
              );

              //
            },
            loaded: (movie) {
              return const Text('movie');

              //
            },
          ),
        );
      },
    );
  }
}
