import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/models/user.dart';
import '../../../domain/repositories/authentication_repository.dart';

const _key = 'sessionID';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  // instanciandolo estamos facilitando el testing
  final FlutterSecureStorage _secureStorage;

  AuthenticationRepositoryImpl(this._secureStorage);

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
}
