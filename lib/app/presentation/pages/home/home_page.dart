import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/enums.dart';
import '../../../domain/repositories/trending_repository.dart';
import '../../global/controller/session_controller.dart';
import 'components/actor/trending_actor.dart';
import 'components/movies/trending_list.dart';
import 'home_controller.dart';
import 'home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(
        // HomeState(loading: true),
        HomeState.loading(timeWindow: TimeWindow.day),
        trendingRepository: context.read<TrendingRepository>(),
      )..init(),
      builder: (_, __) => const HomePage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SessionController sessionController = context.read();
    final user = sessionController.state;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (_, contraints) {
            //
            return RefreshIndicator(
              //
              //
              onRefresh: () async {
                //
              },

              //
              //
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  // * OBTENIENDO LA MAXIMA ALTURA DEL WIDGET HIJO
                  height: contraints.maxHeight,
                  child: Column(
                    children: const [
                      SizedBox(height: 10),
                      TrendingList(),
                      SizedBox(height: 10),
                      TrendingActor(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
