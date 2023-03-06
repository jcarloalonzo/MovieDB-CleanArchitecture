import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/enums.dart';
import '../../../domain/models/actors/actors.dart';
import '../../../domain/models/media/media.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(MoviesState.loading(timeWindow: TimeWindow.day))
        //
        MoviesState moviesState,

    //
    //
    @Default(ActorsState.loading())
        //
        ActorsState actors,
  }) = _HomeState;
}

@freezed
class MoviesState with _$MoviesState {
  const factory MoviesState.loading({required TimeWindow timeWindow}) =
      MoviesStateLoading;
  const factory MoviesState.failed({required TimeWindow timeWindow}) =
      MoviesStateFailed;
  const factory MoviesState.loaded({
    required TimeWindow timeWindow,
    required List<Media> movies,
  }) = MoviesStateLoaded;
}

@freezed
class ActorsState with _$ActorsState {
  const factory ActorsState.loading() = ActorsStateLoading;
  const factory ActorsState.failed() = ActorsStateFailed;
  const factory ActorsState.loaded(List<Actor> actors) = ActorsStateLoaded;
}

//
//
//
//

// factory MoviesState({
//   required bool loading,
//   List<Media>? movies,
//   @Default(TimeWindow.day) TimeWindow timeWindow,
// }) = _HomeState;
