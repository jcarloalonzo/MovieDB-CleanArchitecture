import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global/controller/favorites/favorites_controller.dart';
import '../../global/widgets/request_failed.dart';
import 'components/favorites_appbar.dart';
import 'components/favorites_content.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<FavoritesController>();

    return Scaffold(
      appBar: FavoritesAppBar(tabController: _tabController),
      body: bloc.state.map(
        loading: (_) {
          return const CircularProgressIndicator();

          //
        },
        failed: (_) {
          return RequestFailed(
            onRetry: () {
              bloc.init();
            },
          );

          //
        },
        loaded: (state) {
          return FavoritesContent(
            state: state,
            tabController: _tabController,
          );

          //
        },
      ),
    );
  }
}
