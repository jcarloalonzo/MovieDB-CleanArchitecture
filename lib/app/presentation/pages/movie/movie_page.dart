import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/repositories/movies_repository.dart';
import '../../global/widgets/request_failed.dart';
import 'components/movie_app_bar.dart';
import 'components/movie_content.dart';
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
          extendBodyBehindAppBar: true,
          appBar: const MovieAppBar(),
          body: bloc.state.map(
              loading: (_) {
                return const Center(child: CircularProgressIndicator());
              },
              failed: (_) {
                return RequestFailed(
                  onRetry: () {
                    bloc.init();
                  },
                );
              },
              loaded: (state) => MovieContent(state: state)),
        );
      },
    );
  }
}
