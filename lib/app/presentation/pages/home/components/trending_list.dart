import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/either/either.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../domain/models/media/media.dart';
import '../../../../domain/repositories/trending_repository.dart';
import 'trending_tile.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({super.key});

  //

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TrendingRepository>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'TRENDING',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 16 / 8,
          child: LayoutBuilder(
            builder: (_, constraints) {
              final width = constraints.maxHeight * 0.75;
              return Center(
                child: FutureBuilder<Either<HttpRequestFailure, List<Media>>>(
                  future: bloc.getMoviesAndSeries(TimeWindow.day),
                  builder: (_, snapshot) {
                    // if (snapshot.connectionState == ConnectionState.waiting) {
                    //   return const Center(child: CircularProgressIndicator());
                    // }

                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return snapshot.data!.when(
                      left: (failure) {
                        return const Text('text');
                      },
                      right: (list) {
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final media = list[index];
                            return TrendingTile(
                              media: media,
                              width: width,
                            );
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 10),
                          itemCount: list.length,
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
