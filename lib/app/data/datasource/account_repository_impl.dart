import '../../domain/either/either.dart';
import '../../domain/failures/http_request/http_request_failure.dart';
import '../../domain/models/media/media.dart';
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

  @override
  Future<Either<HttpRequestFailure, Map<int, Media>>> getFavorites(
      MediaType type) async {
    final x = await _accountAPI.getFavorites(type);
    print(x);
    return x;
  }

  @override
  Future<Either<HttpRequestFailure, void>> markAsFavorite({
    required int mediaID,
    required MediaType type,
    required bool favorite,
  }) {
    return _accountAPI.markAsFavorite(
        mediaID: mediaID, type: type, favorite: favorite);
  }
}
