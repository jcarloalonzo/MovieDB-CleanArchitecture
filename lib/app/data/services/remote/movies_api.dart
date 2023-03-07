import '../../../domain/either/either.dart';
import '../../../domain/failures/http_request/http_request_failure.dart';
import '../../../domain/models/movie/movie.dart';
import '../../http/http.dart';
import '../../utils/handle_failure.dart';

class MovieAPI {
  MovieAPI(this._http);

  final Http _http;

  Future<Either<HttpRequestFailure, Movie>> getMovieByID(int id) async {
    final response = await _http.request(
      '/movie/$id',
      onSuccess: (json) {
        return Movie.fromJson(json);
      },
    );

    //
    return response.when(
      left: (httpFailure) {
        return handleHttpFailure(httpFailure);
      },
      right: (movie) {
        return Either.right(movie);
        //
      },
    );
  }
}
