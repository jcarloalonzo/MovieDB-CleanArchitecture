import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controller/favorites/favorites_controller.dart';
import '../../../global/utils/mark_as_favorite.dart';
import '../movie_controller.dart';

class MovieAppBar extends StatelessWidget with PreferredSizeWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<MovieController>();
    final favoritesController = context.watch<FavoritesController>();
    return AppBar(
      //
      backgroundColor: Colors.transparent,
      actions: bloc.state.mapOrNull(
        loaded: (movieState) {
          return [
            favoritesController.state.maybeMap(
              orElse: () {
                return const SizedBox();
              },
              loaded: (favoritesState) {
                return IconButton(
                  onPressed: () {
                    markAsFavorite(
                      context: context,
                      media: movieState.movie.toMedia(),
                      mounted: () {
                        return bloc.mounted;
                      },
                    );
                  },
                  icon: Icon(
                    favoritesState.movies.containsKey(movieState.movie.id)
                        ? Icons.favorite
                        : Icons.favorite_outline,
                  ),
                );
              },
            )
          ];
        },
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
