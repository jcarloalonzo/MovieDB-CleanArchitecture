import '../../../domain/models/user.dart';
import '../../http/http.dart';

class AccountAPI {
  AccountAPI(this._http);

  final Http _http;

  Future<User?> getAccount(String sessionID) async {
    //
// * GET
    final response = await _http.request(
      '/account',
      queryParameters: {
        'session_id': sessionID,
      },
      onSuccess: (json) {
        return User(id: json['id'], username: json['username']);
      },
    );
    return response.when((_) => null, (user) => user);
    //
    //
    //
  }
}
