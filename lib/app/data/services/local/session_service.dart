import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionID';

class SessionService {
  SessionService(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  Future<String?> get sessionID async {
    final sessionId = await _secureStorage.read(key: _key);
    return sessionId;
  }

  Future<void> saveSessionID(String sessionID) async {
    return _secureStorage.write(
      key: _key,
      value: sessionID,
    );
  }

  Future<void> signOut() {
    return _secureStorage.delete(key: _key);
  }
}
