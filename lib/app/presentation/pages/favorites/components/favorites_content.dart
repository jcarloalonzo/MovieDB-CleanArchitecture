import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/media/media.dart';
import '../../../global/controller/favorites/state/favorites_state.dart';
import '../../../utils/get_image_url.dart';

class FavoritesContent extends StatelessWidget {
  const FavoritesContent(
      {Key? key, required this.state, required this.tabController})
      : super(key: key);

  final FavoritesStateLoaded state;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        FavoritesList(items: state.movies.values.toList()),
        FavoritesList(items: state.series.values.toList()),
      ],
    );
  }
}

class FavoritesList extends StatelessWidget {
  const FavoritesList({super.key, required this.items});
  final List<Media> items;

  @override
  Widget build(BuildContext context) {
    print(items.last.originalName);
    return ListView.builder(
      itemBuilder: (_, index) {
        final item = items[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              ExtendedImage.network(
                getImageURL(item.posterPath!),
                width: 60,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title ?? item.originalName ?? ''),
                    const SizedBox(height: 5),
                    Text(
                      item.overview ?? '',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemCount: items.length,
    );
  }
}
