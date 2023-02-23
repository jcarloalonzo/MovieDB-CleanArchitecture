import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/either/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/models/user.dart';
import '../../../domain/repositories/authentication_repository.dart';
import '../../services/remote/authentication_api.dart';

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
    await _authenticationAPI.createRequestToken();

    // await Future.delayed(const Duration(seconds: 2));
    // if (username != 'test') {
    //   return Either.left(SignInFailure.notFound);
    // }

    // if (password != '123456') {
    //   return Either.left(SignInFailure.unauthorized);
    // }

    // await _secureStorage.write(key: _key, value: '123');

    // return Either.right(User());
    return Either.left(SignInFailure.notFound);
  }

  @override
  Future<void> signOut() async {
    // await _secureStorage.delete(key: _key);
    return _secureStorage.delete(key: _key);
    // * tambien es valido usar el return
  }
}
