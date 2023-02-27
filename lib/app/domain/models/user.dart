import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
    required this.username,
  });

  final int id;
  final String username;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        username,
      ];

  Map<String, dynamic> toJson() => _$UserToJson(this);

  // ignore: sort_constructors_first
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
