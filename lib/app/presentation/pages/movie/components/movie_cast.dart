import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/either/either.dart';
import '../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../domain/models/actors/actors.dart';
import '../../../../domain/repositories/movies_repository.dart';

class MovieCast extends StatefulWidget {
  const MovieCast({super.key, required this.movieID});

  final int movieID;

  @override
  State<MovieCast> createState() => _MovieCastState();
}

class _MovieCastState extends State<MovieCast> {
  late Future<Either<HttpRequestFailure, List<Actor>>> _future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('movieeeeee ${widget.movieID}');

    _initFuture();
  }

  void _initFuture() {
    _future = context.read<MoviesRepository>().getCastByMovie(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<HttpRequestFailure, List<Actor>>>(
      key: ValueKey(_future),
      future: _future,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Text('00');
      },
    );
  }
}
