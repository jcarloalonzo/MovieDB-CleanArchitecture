import '../../../domain/either/either.dart';
import '../../../domain/failures/http_request/http_request_failure.dart';
import '../../../domain/models/media/media.dart';
import '../../../domain/models/user/user.dart';
import '../../http/http.dart';
import '../../utils/handle_failure.dart';
import '../local/session_service.dart';

class AccountAPI {
  AccountAPI(this._http, this._sessionService);

  final Http _http;

  final SessionService _sessionService;

  Future<User?> getAccount(String sessionID) async {
    //
// * GET
    final response = await _http.request(
      '/account',
      queryParameters: {
        'session_id': sessionID,
      },
      onSuccess: (json) {
        // return User(id: json['id'], username: json['username']);
        return User.fromJson(json);
      },
    );

    print(response);

    return response.when(left: (failure) => null, right: (user) => user);
    //
    //
    //
  }

  Future<Either<HttpRequestFailure, Map<int, Media>>> getFavorites(
      MediaType type) async {
    final sessionID = await _sessionService.sessionID ?? '';
    final accountID = await _sessionService.accountID;

    final response = await _http.request(
      '/account/$accountID/favorite/${type == MediaType.movie ? 'movies' : 'tv'}',
      queryParameters: {
        'session_id': sessionID,
      },
      onSuccess: (json) {
        // return getMediaList(json['results']);
        final list = json['results'] as List;

        final iterable = list.map(
          (e) {
            final media = Media.fromJson({...e, 'media_type': type.name});
            return MapEntry(media.id, media);
          },
        );
        final map = <int, Media>{};
        map.addEntries(iterable);
        return map;
        // return list
        //     .where((e) =>
        //         e['media_type'] != 'person' &&
        //         e['poster_path'] != null &&
        //         e['backdrop_path'] != null)
        //     .map((e) => Media.fromJson(e))
        //     .toList();
      },
    );

    return response.when(
      left: (failure) {
        return handleHttpFailure(failure);
      },
      right: (value) {
        return Either.right(value);
      },
    );
  }
}
