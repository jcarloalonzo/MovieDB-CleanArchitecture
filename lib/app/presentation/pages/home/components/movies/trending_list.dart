import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../global/widgets/request_failed.dart';
import '../../home_controller.dart';
import 'trending_tile.dart';
import 'trending_time_window.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeController>();
    final state = bloc.state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrendingTimeWindow(
          timeWindow: bloc.state.timeWindow,
          onChanged: (timeWindow) {
            //
          },
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 16 / 8,
          child: LayoutBuilder(
            builder: (_, constraints) {
              final width = constraints.maxHeight * 0.75;
              return Center(
                child: state.when(
                  loading: (_) {
                    return const CircularProgressIndicator();
                  },
                  failed: (_) {
                    return RequestFailed(
                      onRetry: () {
                        //
                      },
                    );
                  },
                  loaded: (_, list, __) {
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
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemCount: list.length,
                    );
                  },
                ),
                // child: Builder(
                //   builder: (_) {
                //     if (state.loading) return const CircularProgressIndicator();

                //     if (state.movies == null) {
                //       return RequestFailed(onRetry: () {});
                //     }

                //     return ListView.separated(
                //       padding: const EdgeInsets.symmetric(horizontal: 15),
                //       scrollDirection: Axis.horizontal,
                //       itemBuilder: (context, index) {
                //         final media = state.movies![index];

                //         return TrendingTile(
                //           media: media,
                //           width: width,
                //         );
                //       },
                //       separatorBuilder: (_, __) => const SizedBox(width: 10),
                //       itemCount: state.movies!.length,
                //     );
                //     //
                //     //
                //     //
                //   },
                // ),
                //
              );
            },
          ),
        ),
      ],
    );
  }
}
