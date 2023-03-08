import '../../domain/either/either.dart';
import '../../domain/failures/http_request/http_request_failure.dart';
import '../../domain/models/actors/actors.dart';
import '../../domain/models/movie/movie.dart';
import '../../domain/repositories/movies_repository.dart';
import '../services/remote/movies_api.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  MoviesRepositoryImpl(this._movieAPI);
  final MovieAPI _movieAPI;

  @override
  Future<Either<HttpRequestFailure, Movie>> getMovieByID(int id) {
    return _movieAPI.getMovieByID(id);
  }

  @override
  Future<Either<HttpRequestFailure, List<Actor>>> getCastByMovie(int id) async {
    final x = await _movieAPI.getCastByMovie(id);
    return x;
  }
}
