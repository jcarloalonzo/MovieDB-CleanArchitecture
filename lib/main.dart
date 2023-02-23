import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'app/data/data/datasource/authentication_repository_impl.dart';
import 'app/data/data/datasource/connectivity_repository_impl.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connecivity_repository.dart';
import 'app/presentation/my_app.dart';

void main() {
  runApp(
    Injector(
        authenticationRepository: AuthenticationRepositoryImpl(
            const FlutterSecureStorage(), AuthenticationAPI(http.Client())),
        connectivityRepository: ConnectivityRepositoryImpl(
          Connectivity(),
          InternetChecker(),
        ),
        child: const MyApp()),
  );
}

class Injector extends InheritedWidget {
  const Injector(
      {required this.connectivityRepository,
      required this.authenticationRepository,
      super.key,
      required super.child});

  final ConnectivityRepository connectivityRepository;
  final AuthenticationRepository authenticationRepository;

  @override
  bool updateShouldNotify(_) => false;

  static Injector of(BuildContext context) {
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, 'Injector could not be found');
    return injector!;
  }
}
