import 'package:flutter/material.dart';

import '../pages/home/pages/home_page.dart';
import '../pages/offline/pages/offline_page.dart';
import '../pages/sign_in/pages/sign_in_page.dart';
import '../pages/splash/splash_page.dart';
import 'routes.dart';

class MyRoutes {
  static Map<String, WidgetBuilder> listRoutes = {
    Routes.splash: (context) => const SplashPage(),
    Routes.signin: (context) => const SignInPage(),
    Routes.home: (context) => const HomePage(),
    Routes.offline: (context) => const OffLinePage(),
  };
}
