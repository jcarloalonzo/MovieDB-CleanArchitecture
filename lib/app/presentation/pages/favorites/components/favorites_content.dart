import 'package:flutter/material.dart';

import '../../../global/controller/favorites/state/favorites_state.dart';

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
      children: const [
        Text('Movies'),
        Text('Series'),
      ],
    );
  }
}
