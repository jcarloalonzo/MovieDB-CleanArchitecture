// To parse this JSON data, do
//
//     final actors = actorsFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

import '../media/media.dart';

part 'actors.freezed.dart';
part 'actors.g.dart';

@freezed
class Actors with _$Actors {
  const factory Actors({
    bool? adult,
    int? id,
    String? name,
    @JsonKey(name: 'original_name') String? originalName,
    double? popularity,
    int? gender,
    @JsonKey(name: 'known_for_department') String? knownForDepartment,
    @JsonKey(name: 'profile_path') String? profilePath,
    @JsonKey(name: 'know_for', fromJson: getMediaList) List<Media>? knownFor,
  }) = _Actors;

  factory Actors.fromJson(Map<String, dynamic> json) => _$ActorsFromJson(json);
}
