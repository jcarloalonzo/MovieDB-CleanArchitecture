import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global/controller/favorites/favorites_controller.dart';
import '../../global/widgets/request_failed.dart';
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
      appBar: AppBar(
        titleTextStyle: const TextStyle(color: Colors.black),
        title: const Text('Favorites'),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: TabBar(
          padding: const EdgeInsets.symmetric(vertical: 10),
          indicatorSize: TabBarIndicatorSize.label,
          indicator: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(30),
          ),
          controller: _tabController,
          labelColor: Colors.black,
          tabs: const [
            SizedBox(
              height: 30,
              child: Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text('Movies'),
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text('Series'),
                ),
              ),
            ),
          ],
        ),
      ),
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
