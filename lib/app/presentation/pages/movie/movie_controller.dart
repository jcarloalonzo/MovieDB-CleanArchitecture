import '../../../domain/repositories/movies_repository.dart';
import '../../global/state_notifier.dart';
import 'movie_state.dart';

class MovieController extends StateNotifier<MovieState> {
  MovieController(super.state,
      {required this.moviesRepository, required this.movieID});

  final MoviesRepository moviesRepository;

  final int movieID;
  Future<void> init() async {
    final result = await moviesRepository.getMovieByID(movieID);

    state = result.when(
      left: (_) => state = MovieState.failed(),
      right: (movie) => state = MovieState.loaded(movie),
    );
    // result.when(
    //   left: (_) {
    //     state = MovieState.failed();
    //   },
    //   right: (movie) {
    //     state = MovieState.loaded(movie);
    //   },
    // );
  }
}
