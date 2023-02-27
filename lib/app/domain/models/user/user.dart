import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String username,

    //
    @JsonKey(
      name: 'avatar',
      fromJson: avatarPathFromJson,
    )
        String? avatarPath,
  }) = _User;

  const User._();

//

  // ignore: sort_constructors_first
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // ignore: sort_constructors_first
  // factory User.fromJson(Map<String, dynamic> json) {
  //   final avatarPath = json['avatar']['tmdb']?['avatar_path'] as String?;
  //   return User(
  //     id: json['id'] as int,
  //     username: json['username'] as String,
  //     avatarPath: avatarPath,
  //   );
  // }

  String getFormatted() {
    return '$username $id';
  }
}

String? avatarPathFromJson(Map<String, dynamic> json) {
  return json['tmdb']?['avatar_path'] as String?;
}
