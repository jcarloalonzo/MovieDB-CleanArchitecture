import 'dart:convert';
import 'dart:io';

import '../../../domain/either/either.dart';
import '../../../domain/enums.dart';
import '../../http/http.dart';

class AuthenticationAPI {
  AuthenticationAPI(this._http);

  final Http _http;

  Future<String?> createRequestToken() async {
    final result = await _http.request('/authentication/token/new');

    // final requestToken = result.when((result) {
    //   return null;
    // }, (responseBody) {
    //   final json = Map<String, dynamic>.from(jsonDecode(responseBody));
    //   return json['request_token'] as String;
    // });
    // return requestToken;

    return result.when(
      (result) {
        return null;
      },
      (responseBody) {
        final json = Map<String, dynamic>.from(jsonDecode(responseBody));
        return json['request_token'] as String;
      },
    );
  }

  Future<Either<SignInFailure, String>> createSessionWithLogin(
      {required String username,
      required String password,
      required String requestToken}) async {
    final result = await _http.request(
      '/authentication/token/validate_with_login',
      method: HttpMethod.post,
      userApiKey: true,
      body: {
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
    );

    return result.when((failure) {
      if (failure.statusCode != null) {
        switch (failure.statusCode) {
          case 401:
            return Either.left(SignInFailure.unauthorized);
          case 404:
            return Either.left(SignInFailure.notFound);
          default:
            return Either.left(SignInFailure.unknown);
        }
      }

      if (failure.exception is NetworkException) {
        return Either.left(
          SignInFailure.network,
        );
      }

      return Either.left(
        SignInFailure.unknown,
      );
    }, (responseBody) {
      final json = Map<String, dynamic>.from(jsonDecode(responseBody));

      final newRequestToken = json['request_token'] as String;
      return Either.right(newRequestToken);
    });
  }

  //
  //

  Future<Either<SignInFailure, String>> createSession(
      String requestToken) async {
    final result = await _http.request(
      '/authentication/session/new',
      method: HttpMethod.post,
      body: {
        'request_token': requestToken,
      },
    );

    return result.when((failure) {
      if (failure is SocketException) {
        return Either.left(SignInFailure.network);
      }
      return Either.left(SignInFailure.unknown);
    }, (responseBody) {
      final json = Map<String, dynamic>.from(jsonDecode(responseBody));
      final sessionID = json['session_id'] as String;
      return Either.right(sessionID);
    });
  }
}
