import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionID';
const _accountKey = 'accountID';

class SessionService {
  SessionService(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  Future<String?> get sessionID async {
    final sessionId = await _secureStorage.read(key: _key);
    return sessionId;
  }

  Future<String?> get accountID async {
    final sessionId = await _secureStorage.read(key: _accountKey);
    return sessionId;
  }

  Future<void> saveSessionID(String sessionID) async {
    return _secureStorage.write(
      key: _key,
      value: sessionID,
    );
  }

  Future<void> saveAccountID(String accountID) async {
    return _secureStorage.write(
      key: _accountKey,
      value: accountID,
    );
  }

  Future<void> signOut() {
    // await _secureStorage.delete(key: _key);
    // await _secureStorage.delete(key: _accountKey);
    return _secureStorage.deleteAll();
  }
}
