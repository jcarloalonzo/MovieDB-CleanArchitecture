import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/either/either.dart';
import '../../domain/enums.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../services/remote/authentication_api.dart';

const _key = 'sessionID';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(this._secureStorage, this._authenticationAPI);
  // instanciandolo estamos facilitando el testing
  final FlutterSecureStorage _secureStorage;
  final AuthenticationAPI _authenticationAPI;

  @override
  Future<User?> getUserData() async {
    // TODO: implement getUserData
    return null;
  }

  @override
  // TODO: implement isSignedIn
  Future<bool> get isSignedIn async {
    final sessionId = await _secureStorage.read(key: _key);
    print(sessionId);
    return sessionId != null;
  }

  @override
  Future<Either<SignInFailure, User>> signIn(
      String username, String password) async {
    final requestTokenResult = await _authenticationAPI.createRequestToken();
    return requestTokenResult.when(
      (failure) async {
//
        return Either.left(failure);
      },
      (requestToken) async {
        final loginResult = await _authenticationAPI.createSessionWithLogin(
          username: username,
          password: password,
          requestToken: requestToken,
        );
        print(loginResult);

        return loginResult.when(
          (failure) async => Either.left(failure),
          (newRequestToken) async {
            final sessionResult =
                await _authenticationAPI.createSession(newRequestToken);
            print(sessionResult);

            sessionResult.when(
              (failure) async => Either.left(failure),
              (sessionId) async {
                await _secureStorage.write(key: _key, value: sessionId);
              },
            );
//

            return Either.right(User());
          },
        );
      },
    );
  }

  @override
  Future<void> signOut() async {
    // await _secureStorage.delete(key: _key);
    return _secureStorage.delete(key: _key);
    // * tambien es valido usar el return
  }
}
