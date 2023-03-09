import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/media/media.dart';
import '../controller/favorites/favorites_controller.dart';
import '../dialogs/show_loader.dart';

Future<void> markAsFavorite({
  required BuildContext context,
  required Media media,
  required bool Function() mounted,
}) async {
  //
  final favoritesController = context.read<FavoritesController>();

  final response = await showLoader(
    context,
    favoritesController.markAsFavorite(media),
  );
  // final response = await favoritesController.markAsFavorite(media);

  if (!mounted()) {
    return;
  }

  response.whenOrNull(left: (failure) {
    final errorMessage = failure.when(
      notFound: () => 'Resource not found',
      network: () => 'Network error',
      unauthorized: () => 'Unauthorized',
      unknow: () => 'Unknown error',
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(errorMessage)));
  });
}
