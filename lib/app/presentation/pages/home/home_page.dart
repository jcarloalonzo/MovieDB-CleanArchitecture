import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global/controller/session_controller.dart';
import 'components/trending_actor.dart';
import 'components/trending_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final SessionController sessionController = context.read();
    final user = sessionController.state;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            SizedBox(height: 10),
            TrendingList(),
            SizedBox(height: 10),
            TrendingActor(),
          ],
        ),
      ),
    );
  }
}
