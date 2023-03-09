import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/media/media.dart';
import '../controller/favorites/favorites_controller.dart';

Future<void> markAsFavorite({
  required BuildContext context,
  required Media media,
}) async {
  //
  final favoritesController = context.read<FavoritesController>();

  final response = await favoritesController.markAsFavorite(media);

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
