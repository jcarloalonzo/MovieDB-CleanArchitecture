import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../movie_controller.dart';

class MovieAppBar extends StatelessWidget with PreferredSizeWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<MovieController>();
    return AppBar(
      //
      backgroundColor: Colors.transparent,
      actions: bloc.state.mapOrNull(
        loaded: (_) {
          return [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline),
            ),
          ];
        },
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
