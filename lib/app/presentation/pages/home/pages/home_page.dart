import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../routes/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            //
            Injector.of(context).authenticationRepository.signOut();

            Navigator.pushReplacementNamed(context, Routes.signin);
          },
          child: const Text('Singout'),
        ),
      ),
    );
  }
}
