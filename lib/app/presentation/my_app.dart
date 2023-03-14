import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'global/controller/theme_controller.dart';
import 'global/theme.dart';
import 'routes/app_routes.dart';
import 'routes/routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    return GestureDetector(
      onTap: () {
        // * ESTO ES PARA CUANDO DES CLICK FUERA SE PIERDA EL FOCUS DEL TECLADO
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        theme: getTheme(themeController.darkMode),
        initialRoute: Routes.splash,
        routes: MyRoutes.listRoutes,

        //
      ),
    );
  }
}
