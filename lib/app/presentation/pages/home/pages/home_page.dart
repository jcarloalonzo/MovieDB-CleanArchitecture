import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controller/session_controller.dart';
import '../../../routes/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final SessionController sessionController = context.read();
    final user = sessionController.state;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(user?.id.toString() ?? ''),
              Text(user?.username ?? ''),
              TextButton(
                onPressed: () async {
                  await sessionController.signOut();

                  if (!context.mounted) return;

                  Navigator.pushReplacementNamed(context, Routes.signin);
                },
                child: const Text('Singout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
