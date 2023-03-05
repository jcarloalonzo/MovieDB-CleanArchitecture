import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/either/either.dart';
import '../../../../../domain/enums.dart';
import '../../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../../domain/models/media/media.dart';
import '../../../../../domain/repositories/trending_repository.dart';
import 'trending_tile.dart';
import 'trending_time_window.dart';

class TrendingList extends StatefulWidget {
  const TrendingList({super.key});

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  late Future<Either<HttpRequestFailure, List<Media>>> _future;
  final TimeWindow _timeWindow = TimeWindow.day;

  TrendingRepository get _repository => context.read<TrendingRepository>();
  //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final TrendingRepository repository = context.read();
    _future = repository.getMoviesAndSeries(_timeWindow);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TrendingRepository>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrendingTimeWindow(
            timeWindow: _timeWindow,
            onChanged: (timeWindow) {
              setState(() {
                timeWindow = timeWindow;
                _future = _repository.getMoviesAndSeries(timeWindow);
              });
            }),

        // https://www.udemy.com/course/flutter-desde-cero-darwin-morocho/learn/lecture/35170188#questions
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 16 / 8,
          child: LayoutBuilder(
            builder: (_, constraints) {
              final width = constraints.maxHeight * 0.75;
              return Center(
                child: FutureBuilder<Either<HttpRequestFailure, List<Media>>>(
                  key: ValueKey(_future),
                  // future: bloc.getMoviesAndSeries(TimeWindow.day),
                  future: _future,

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
