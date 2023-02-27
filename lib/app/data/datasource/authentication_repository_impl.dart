import '../../domain/either/either.dart';
import '../../domain/failures/sign_in_failure.dart';
import '../../domain/models/user/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../services/local/session_service.dart';
import '../services/remote/account_api.dart';
import '../services/remote/authentication_api.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(
      this._authenticationAPI, this._sessionService, this._accountAPI);
  // instanciandolo estamos facilitando el testing
  final AuthenticationAPI _authenticationAPI;
  final SessionService _sessionService;
  final AccountAPI _accountAPI;

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await _sessionService.sessionID;
    return sessionId != null;
  }

  @override
  Future<Either<SignInFailure, User>> signIn(
      String username, String password) async {
    final requestTokenResult = await _authenticationAPI.createRequestToken();
    return requestTokenResult.when(
      (failure) async {
        return Either.left(failure);
      },
      (requestToken) async {
        final loginResult = await _authenticationAPI.createSessionWithLogin(
          username: username,
          password: password,
          requestToken: requestToken,
        );
        return loginResult.when(
          (failure) async => Either.left(failure),
          (newRequestToken) async {
            final sessionResult =
                await _authenticationAPI.createSession(newRequestToken);
            return sessionResult.when(
              (failure) async => Either.left(failure),
              (sessionID) async {
                await _sessionService.saveSessionID(sessionID);
                final user = await _accountAPI.getAccount(sessionID);
                if (user == null) return Either.left(Unknown());
                return Either.right(user);
              },
            );
          },
        );
      },
    );
  }

  @override
  Future<void> signOut() async {
    // await _secureStorage.delete(key: _key);
    // * tambien es valido usar el return

    return _sessionService.signOut();
  }
}
