import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    this.avatarPath,
  });

  final int id;
  final String username;

  @JsonKey(fromJson: avatarPathFromJson, name: 'avatar')
  final String? avatarPath;

//
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        username,
      ];

  Map<String, dynamic> toJson() => _$UserToJson(this);
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
}

String? avatarPathFromJson(Map<String, dynamic> json) {
  return json['tmdb']?['avatar_path'] as String?;
}
