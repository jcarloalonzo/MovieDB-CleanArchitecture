import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'app/data/datasource/authentication_repository_impl.dart';
import 'app/data/datasource/connectivity_repository_impl.dart';
import 'app/data/http/http.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connecivity_repository.dart';
import 'app/presentation/my_app.dart';

void main() {
  runApp(
    Provider<ConnectivityRepository>(
      create: (context) => ConnectivityRepositoryImpl(
        Connectivity(),
        InternetChecker(),
      ),
      child: Provider<AuthenticationRepository>(
          create: (context) => AuthenticationRepositoryImpl(
                const FlutterSecureStorage(),
                AuthenticationAPI(
                  Http(
                    baseUrl: 'https://api.themoviedb.org/3',
                    apiKey: '8f8784dbe3b56f66943479112eb78617',
                    client: http.Client(),
                  ),
                ),
              ),
          child: const MyApp()),
    ),
  );
}
