import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global/controller/theme_controller.dart';
import '../../global/extensions/build_context_ext.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final bool value = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SwitchListTile(
              value: context.darkMode,
              onChanged: (v) {
                context.read<ThemeController>().onChanged(v);
              },
              title: const Text('Dark Mode'),
            ),
          ],
        ),
      )),
    );
  }
}
