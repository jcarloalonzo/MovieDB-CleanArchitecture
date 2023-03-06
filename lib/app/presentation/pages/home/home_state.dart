import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/enums.dart';
import '../../../domain/models/media/media.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState.loading({required TimeWindow timeWindow}) =
      HomeStateLoading;
  factory HomeState.failed({required TimeWindow timeWindow}) = HomeStateFailed;
  factory HomeState.loaded({
    required List<Media> movies,
    required TimeWindow timeWindow,
  }) = HomeStateLoaded;
}


// 
// 
// 
// 


  // factory HomeState({
  //   required bool loading,
  //   List<Media>? movies,
  //   @Default(TimeWindow.day) TimeWindow timeWindow,
  // }) = _HomeState;