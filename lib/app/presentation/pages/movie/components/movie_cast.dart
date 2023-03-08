import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/either/either.dart';
import '../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../domain/models/actors/actors.dart';
import '../../../../domain/repositories/movies_repository.dart';
import '../../../global/widgets/request_failed.dart';
import '../../../utils/get_image_url.dart';

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
        return snapshot.data!.when(
          left: (_) {
            return RequestFailed(
              onRetry: () {
                setState(() {
                  _initFuture();
                });
              },
            );
          },
          right: (list) {
            return Column(
              children: [
                const Text(
                  'Cast',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (_, index) {
                      final actor = list[index];
                      return Column(
                        children: [
                          Expanded(
                            child: LayoutBuilder(
                              builder: (_, contraints) {
                                final size = contraints.maxHeight;
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(size / 2),
                                  child: ExtendedImage.network(
                                    getImageURL(actor.profilePath!),
                                    height: size,
                                    width: size,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            actor.name ?? '',
                            style: const TextStyle(fontSize: 11),
                          ),
                        ],
                      );

                      //
                    },
                  ),
                )
              ],
            );
            //
          },
        );
      },
    );
  }
}
