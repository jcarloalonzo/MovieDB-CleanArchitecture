import '../../../domain/repositories/trending_repository.dart';
import '../../global/state_notifier.dart';
import 'home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController(super.state, {required this.trendingRepository});

  final TrendingRepository trendingRepository;

  Future<void> init() async {
    //

    final result =
        await trendingRepository.getMoviesAndSeries(state.timeWindow);

    result.when(
      left: (_) {
        state = state.copyWith(
          loading: false,
          movies: null,
        );
      },
      right: (list) {
        state = state.copyWith(
          loading: false,
          movies: list,
        );
        //
      },
    );
    //
  }
}
