import '../../../domain/models/user.dart';
import '../../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<User?> getUserData() async {
    // TODO: implement getUserData
    return null;
  }

  @override
  // TODO: implement isSignedIn
  Future<bool> get isSignedIn {
    return Future.value(false);
  }
}
