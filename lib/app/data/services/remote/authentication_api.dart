import 'dart:convert';

import 'package:http/http.dart';

class AuthenticationAPI {
  AuthenticationAPI(this._client);
  final Client _client;

  final _apiKey = '8f8784dbe3b56f66943479112eb78617';
  final _baseUrl = 'https://api.themoviedb.org/3';

  Future<String?> createRequestToken() async {
    final response = await _client
        .get(Uri.parse('$_baseUrl/authentication/token/new?api_key=$_apiKey'));
    print('💋 ${response.statusCode}');
    print('💖  ${response.body}');
    if (response.statusCode == 200) {
      jsonDecode(response.body);
    }
    return null;
  }
}
