import 'package:flutter/material.dart';

Future showLoader<T>(BuildContext context, Future<T> future) async {
  final overlayState = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) {
      return Container(
        color: Colors.black45,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
  overlayState.insert(overlayEntry);
  final result = await future;
  overlayEntry.remove();
  return result;
}
