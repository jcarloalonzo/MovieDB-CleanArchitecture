import 'package:freezed_annotation/freezed_annotation.dart';

part 'media.freezed.dart';
part 'media.g.dart';

@freezed
class Media with _$Media {
  factory Media({
    required int id,
    required String title,
    @JsonKey(name: 'original_title') required String originalTitle,
    @JsonKey(name: 'poster_path') required String posterPath,
    @JsonKey(name: 'backdrop_path') required String backdropPath,
    @JsonKey(name: 'vote_average') required String voteAverage,
    @JsonKey(name: 'media_type') required String mediaType,
  }) = _Media;

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
}

// class QWE {
//   sdasd() {
//     Media s = Media(id: 1, title: '2');

//     s.toJson();

//     s.toJson()
//   }
// }
