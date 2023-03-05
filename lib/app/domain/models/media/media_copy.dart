// // To parse this JSON data, do
// //
// //     final media = mediaFromJson(jsonString);

// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'media.freezed.dart';
// part 'media.g.dart';

// @freezed
// class MediaResponse with _$MediaResponse {
//   const factory MediaResponse({
//     int? page,
//     List<Media>? results,
//     @JsonKey(name: 'total_pages') int? totalPages,
//     @JsonKey(name: 'total_results') int? totalResults,
//   }) = _MediaResponse;

//   factory MediaResponse.fromJson(Map<String, dynamic> json) =>
//       _$MediaResponseFromJson(json);
// }

// @freezed
// class Media with _$Media {
//   const factory Media({
//     bool? adult,
//     @JsonKey(name: 'total_results') String? backdropPath,
//     int? id,
//     String? title,
//     @JsonKey(name: 'original_language') String? originalLanguage,
//     @JsonKey(name: 'original_title') String? originalTitle,
//     String? overview,
//     @JsonKey(name: 'posert_path') String? posterPath,
//     String? mediaType,
//     @JsonKey(name: 'genre_ids') List<int>? genreIds,
//     double? popularity,
//     @JsonKey(name: 'release_date') DateTime? releaseDate,
//     bool? video,
//     @JsonKey(name: 'vote_average') double? voteAverage,
//     @JsonKey(name: 'vote_count') int? voteCount,
//   }) = _Media;

//   factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
// }
