import '../../../domain/either/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/failures/http_request/http_request_failure.dart';
import '../../../domain/models/media/media.dart';
import '../../http/http.dart';
import '../../utils/handle_failure.dart';

class TrendingAPI {
  TrendingAPI(this._http);

  final Http _http;

  Future<Either<HttpRequestFailure, List<Media>>> getMoviesAndSeries(
      TimeWindow timeWindow) async {
    final response = await _http.request(
      '/trending/all/${timeWindow.name}',
      onSuccess: (json) {
        //
        final list = json['result'] as List<Map<String, dynamic>>;

        return list
            .where((e) => e['media_type'] != 'person')
            .map((e) => Media.fromJson(e))
            .toList();
      },
    );

    return response.when(
        left: (httpFailure) => handleHttpFailure(httpFailure),
        right: (list) {
          return Either.right(list);
        });
  }
}
