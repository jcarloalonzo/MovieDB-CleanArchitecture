// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

import '../genre/genre.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    bool? adult,
    @JsonKey(name: 'backdrop_path') required String backdropPath,
    int? budget,
    required List<Genre> genres,
    String? homepage,
    required int id,
    String? imdbId,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_title') String? originalTitle,
    String? overview,
    double? popularity,
    @JsonKey(name: 'poster_path') required String posterPath,
    @JsonKey(name: 'release_date') DateTime? releaseDate,
    int? revenue,
    int? runtime,
    String? status,
    String? tagline,
    String? title,
    bool? video,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'vote_count') int? voteCount,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
