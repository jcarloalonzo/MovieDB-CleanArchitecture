import '../../../../domain/either/either.dart';
import '../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../domain/models/media/media.dart';
import '../../../../domain/repositories/account_repository.dart';
import '../../state_notifier.dart';
import 'state/favorites_state.dart';

class FavoritesController extends StateNotifier<FavoritesState> {
  FavoritesController(super.state, {required this.accountRepository});

  final AccountRepository accountRepository;

  Future<void> init() async {
    state = FavoritesState.loading();
    final moviesResult = await accountRepository.getFavorites(MediaType.movie);
    //
    state = await moviesResult.when(
      left: (_) async {
        return state = FavoritesState.failed();
      },
      right: (movies) async {
        //
        final seriesResult = await accountRepository.getFavorites(MediaType.tv);
        return seriesResult.when(
          left: (_) {
            print(_);
            return state = FavoritesState.failed();
            //
          },
          right: (series) {
            return state =
                FavoritesState.loaded(movies: movies, series: series);
          },
        );
      },
    );
  }

  Future<Either<HttpRequestFailure, void>> markAsFavorite(Media media) async {
    assert(state is FavoritesStateLoaded);
    final loadedState = state as FavoritesStateLoaded;
    final bool isMovie = media.mediaType == MediaType.movie;
    final map = isMovie ? {...loadedState.movies} : {...loadedState.series};

    //

    final favorite = !map.keys.contains(media.id);

    final result = await accountRepository.markAsFavorite(
      mediaID: media.id,
      type: media.mediaType!,
      favorite: favorite,
    );

    result.whenOrNull(right: (_) {
      // * ACA ESTAMOS TRABAJANDO CON LA COPIA
      if (favorite) {
        map[media.id] = media;
      } else {
        map.remove(media.id);
      }

      // *AQUI VALIDAMOS EL ESTADO
      state = isMovie
          ? loadedState.copyWith(
              movies: map,
            )
          : loadedState.copyWith(
              series: map,
            );
    });

    return result;
//     state.mapOrNull(loaded: (loadedState) async {
//       // final keys = media.mediaType == MediaType.movie
//       //     ? loadedState.movies.keys
//       //     : loadedState.series.keys;

// //
// //

//       // final map = media.mediaType == MediaType.movie
//       //     ? loadedState.movies
//       //     : loadedState.series;

// //*para crear la copia de un map
//       // final map = Map<int, Media>.from(media.mediaType == MediaType.movie
//       //     ? loadedState.movies
//       //     : loadedState.series);
//       final bool isMovie = media.mediaType == MediaType.movie;
//       final map = isMovie ? {...loadedState.movies} : {...loadedState.series};

//       //

//       final favorite = !map.keys.contains(media.id);

//       final result = await accountRepository.markAsFavorite(
//         mediaID: media.id,
//         type: media.mediaType!,
//         favorite: favorite,
//       );

//       result.whenOrNull(right: (_) {
//         // * ACA ESTAMOS TRABAJANDO CON LA COPIA
//         if (favorite) {
//           map[media.id] = media;
//         } else {
//           map.remove(media.id);
//         }

//         // *AQUI VALIDAMOS EL ESTADO
//         state = isMovie
//             ? loadedState.copyWith(
//                 movies: map,
//               )
//             : loadedState.copyWith(
//                 series: map,
//               );
//       });
//     });
  }
}
