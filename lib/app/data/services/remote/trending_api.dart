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
        print(json);
        print(json.runtimeType);

        // var a = (json['results'] as List)
        //     .
        //     //
        //     map((e) => Media.fromJson(e))
        //     .toList();

        var list = List<Map<String, dynamic>>.from(json['results']);

        return getMediaList(list);

        // final list = s
        //     .where((e) =>
        //         e['media_type'] != 'person' &&
        //         e['poster_path'] != null &&
        //         e['backdrop_path'])
        //     .map((e) => Media.fromJson(e))
        //     .toList();

        // return list;
        // final list = json['results'] as List<Map<String, dynamic>>;
        // final list = List<Map<String, dynamic>>.from(json['results']);

        // print(list);
        // return list
        //     .where((e) => e['media_type'] != 'person')
        //     .map((e) => Media.fromJson(e))
        //     .toList();

        // final x = MediaResponse.fromJson(json);
        // print(x);

        // return x.results;
      },
    );

    return response.when(
        left: (httpFailure) => handleHttpFailure(httpFailure),
        right: (list) {
          // return Either.right(list);
          return Either.right(list);
        });
  }
}
