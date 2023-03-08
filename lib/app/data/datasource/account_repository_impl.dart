import '../../domain/models/user/user.dart';
import '../../domain/repositories/account_repository.dart';
import '../services/local/session_service.dart';
import '../services/remote/account_api.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl(
    this._accountAPI,
    this._sessionService,
  );

  final AccountAPI _accountAPI;
  final SessionService _sessionService;
  @override
  Future<User?> getUserData() async {
    final sessionID = await _sessionService.sessionID;
    final user = await _accountAPI.getAccount(sessionID ?? '');

    if (user != null) {
      _sessionService.saveAccountID(user.id.toString());
    }
    return user;
  }
}
