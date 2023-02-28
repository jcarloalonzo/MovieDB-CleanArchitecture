// // To parse this JSON data, do
// //
// //     final user = userFromJson(jsonString);

// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'user.freezed.dart';
// part 'user.g.dart';

// @freezed
// class User with _$User {
//   const factory User({
//     Avatar? avatar,
//     int? id,
//     String? iso6391,
//     String? iso31661,
//     String? name,
//     @JsonKey(name: 'include_adult') bool? includeAdult,
//     String? username,
//   }) = _User;

//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
// }

// @freezed
// class Avatar with _$Avatar {
//   const factory Avatar({
//     Gravatar? gravatar,
//     Tmdb? tmdb,
//   }) = _Avatar;

//   factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
// }

// @freezed
// class Gravatar with _$Gravatar {
//   const factory Gravatar({
//     String? hash,
//   }) = _Gravatar;

//   factory Gravatar.fromJson(Map<String, dynamic> json) =>
//       _$GravatarFromJson(json);
// }

// @freezed
// class Tmdb with _$Tmdb {
//   const factory Tmdb({
//     @JsonKey(name: 'avatar_path') String? avatarPath,
//   }) = _Tmdb;

//   factory Tmdb.fromJson(Map<String, dynamic> json) => _$TmdbFromJson(json);
// }
