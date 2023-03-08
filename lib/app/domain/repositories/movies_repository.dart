import '../either/either.dart';
import '../failures/http_request/http_request_failure.dart';
import '../models/actors/actors.dart';
import '../models/movie/movie.dart';

abstract class MoviesRepository {
  Future<Either<HttpRequestFailure, Movie>> getMovieByID(int id);
  Future<Either<HttpRequestFailure, List<Actor>>> getCastByMovie(int id);
}
