import '../../../domain/either/either.dart';
import '../../../domain/enums.dart';
import '../../http/http.dart';

class AuthenticationAPI {
  AuthenticationAPI(this._http);

  final Http _http;

  Either<SignInFailure, String> _handleFailure(HttpFailure failure) {
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
  }

  Future<Either<SignInFailure, String>> createRequestToken() async {
    final result = await _http.request(
      '/authentication/token/new',
      onSuccess: (responseBody) {
        print(responseBody);
        // final json = Map<String, dynamic>.from(jsonDecode(responseBody));
        final json = responseBody as Map;

        print(json);
        return json['request_token'] as String;
        // return 'qwe';
      },
    );
    // final requestToken = result.when((result) {
    //   return null;
    // }, (responseBody) {
    //   final json = Map<String, dynamic>.from(jsonDecode(responseBody));
    //   return json['request_token'] as String;
    // });
    // return requestToken;
    print(result);
    return result.when(
      (failure) {
        return _handleFailure(failure);
      },
      (requestToken) {
        return Either.right(requestToken);
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
      bodyRequest: {
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
      onSuccess: (responseBody) {
        print(responseBody);
        // final json = Map<String, dynamic>.from(jsonDecode(responseBody));
        // print(json['request_token'] as String);
        final json = responseBody as Map;

        return json['request_token'] as String;
      },
    );
    print(result);

    return result.when(
      // *es lo mismo que lo de arriba
      _handleFailure,
      (requestToken) {
        return Either.right(requestToken);
      },
    );
  }

  //
  //

  Future<Either<SignInFailure, String>> createSession(
      String requestToken) async {
    final result = await _http.request(
      '/authentication/session/new',
      method: HttpMethod.post,
      bodyRequest: {
        'request_token': requestToken,
      },
      onSuccess: (responseBody) {
        print(responseBody);
        // final json = Map<String, dynamic>.from(jsonDecode(responseBody));
        final json = responseBody as Map;

        return json['session_id'] as String;
      },
    );

    print(result);
    return result.when((failure) {
      return _handleFailure(failure);
    }, (sessionId) {
      return Either.right(sessionId);
    });
  }
}
