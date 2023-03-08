import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'app/data/datasource/account_repository_impl.dart';
import 'app/data/datasource/authentication_repository_impl.dart';
import 'app/data/datasource/connectivity_repository_impl.dart';
import 'app/data/datasource/movies_repository_impl.dart';
import 'app/data/datasource/trending_repository_impl.dart';
import 'app/data/http/http.dart';
import 'app/data/services/local/session_service.dart';
import 'app/data/services/remote/account_api.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/data/services/remote/movies_api.dart';
import 'app/data/services/remote/trending_api.dart';
import 'app/domain/repositories/account_repository.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connecivity_repository.dart';
import 'app/domain/repositories/movies_repository.dart';
import 'app/domain/repositories/trending_repository.dart';
import 'app/presentation/global/controller/favorites/favorites_controller.dart';
import 'app/presentation/global/controller/favorites/state/favorites_state.dart';
import 'app/presentation/global/controller/session_controller.dart';
import 'app/presentation/my_app.dart';

void main() {
  final sessionService = SessionService(
    const FlutterSecureStorage(),
  );
  final http = Http(
    baseUrl: 'https://api.themoviedb.org/3',
    apiKey: '8f8784dbe3b56f66943479112eb78617',
    client: Client(),
  );

  //

  final accountAPI = AccountAPI(http);

  runApp(
    MultiProvider(
      providers: [
        Provider<AccountRepository>(
          create: (_) => AccountRepositoryImpl(
            accountAPI,
            sessionService,
          ),
        ),
        Provider<ConnectivityRepository>(
          create: (_) => ConnectivityRepositoryImpl(
            Connectivity(),
            InternetChecker(),
          ),
        ),
        Provider<AuthenticationRepository>(
          create: (_) {
            return AuthenticationRepositoryImpl(
              AuthenticationAPI(
                http,
              ),
              sessionService,
              accountAPI,
            );
          },
        ),
        Provider<MoviesRepository>(
          create: (_) {
            return MoviesRepositoryImpl(
              MovieAPI(
                http,
              ),
            );
          },
        ),
        //
        //

        Provider<TrendingRepository>(
          create: (_) => TrendingRepositoryImpl(
            TrendingAPI(http),
          ),
        ),
        //
        //

        ChangeNotifierProvider<SessionController>(
          create: (context) => SessionController(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
        ),

        //
        ChangeNotifierProvider<FavoritesController>(
          create: (context) => FavoritesController(
            FavoritesState.loading(),
          ),
        ),
        //
        //
      ],
      child: const MyApp(),
    ),
  );
}
