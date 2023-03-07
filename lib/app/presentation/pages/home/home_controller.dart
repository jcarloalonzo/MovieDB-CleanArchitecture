import '../../../domain/enums.dart';
import '../../../domain/repositories/trending_repository.dart';
import '../../global/state_notifier.dart';
import 'home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController(super.state, {required this.trendingRepository});

  final TrendingRepository trendingRepository;

  Future<void> init() async {
    await getMovies();
    await getActors();
  }

  Future<void> getMovies({MoviesState? moviesState}) async {
    if (moviesState != null) {
      state = state.copyWith(moviesState: moviesState);
    }

    final result = await trendingRepository
        .getMoviesAndSeries(state.moviesState.timeWindow);

    result.when(
      left: (_) {
        state = state.copyWith(
            moviesState:
                MoviesState.failed(timeWindow: state.moviesState.timeWindow));
      },
      right: (list) {
        //
        state = state.copyWith(
            moviesState: MoviesState.loaded(
                timeWindow: state.moviesState.timeWindow, movies: list));
      },
    );
  }

  Future<void> getActors({ActorsState? actorState}) async {
    if (actorState != null) {
      state = state.copyWith(actors: actorState);
    }

    final actorsResult = await trendingRepository.getActors();

    actorsResult.when(
      left: (_) {
        state = state.copyWith(actors: const ActorsState.failed());
      },
      right: (list) {
        //
        state = state.copyWith(actors: ActorsState.loaded(list));
      },
    );
  }

  void onTimeWindowsChanged(TimeWindow timeWindow) async {
    if (state.moviesState.timeWindow == timeWindow) return;
    state = state.copyWith(
        moviesState: MoviesState.loading(timeWindow: timeWindow));
    getMovies();
  }

  //
  //
}
