// To parse this JSON data, do
//
//     final media = mediaFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'media.freezed.dart';
part 'media.g.dart';

@freezed
class Media with _$Media {
  const factory Media({
    bool? adult,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    int? id,
    String? name,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_name') String? originalName,
    String? overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    // @JsonKey(name: 'media_type') String? mediaType,
    @JsonKey(name: 'media_type') MediaType? mediaType,
    @JsonKey(name: 'genre_ids') List<int>? genreIds,
    double? popularity,
    @JsonKey(name: 'first_air_date') DateTime? firstAirDate,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') int? voteCount,
    @JsonKey(name: 'origin_country') List<String>? originCountry,
    String? title,
    @JsonKey(name: 'original_title') String? originalTitle,
    @JsonKey(name: 'release_date') DateTime? releaseDate,
    bool? video,
  }) = _Media;

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
}

// en ves de trabjar con string mejor trabajamos con enums para evitar errores de tipografia y comparaciones
enum MediaType {
  @JsonValue('movie')
  movie,
  @JsonValue('tv')
  tv,
}

List<Media> getMediaList(List list) {
  return list
      .where((e) =>
          e['media_type'] != 'person' &&
          e['poster_path'] != null &&
          e['backdrop_path'] != null)
      .map((e) => Media.fromJson(e))
      .toList();
}
