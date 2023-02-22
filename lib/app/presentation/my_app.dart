
import 'package:flutter/material.dart';

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
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,

      routes: MyRoutes.listRoutes,
    );
  }
}
