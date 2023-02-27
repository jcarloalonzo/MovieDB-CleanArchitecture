import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    @Default('') String username,
    @Default('') String password,
    @Default(false) bool fetching,
  }) = _SignInState;
}


// @freezed
// class SignInState with _$SignInState {
//   factory SignInState({
//     required String username,
//     required String password,
//     required bool fetching,
//   }) = _SignInState;
// }



// 
// 








// 
// 
// class SignInState extends Equatable {
//   const SignInState(
//       {this.username = '', this.password = '', this.fetching = false});

//   final String username, password;
//   final bool fetching;

//   // factory SignInState.copyWith()=>;
//   SignInState copywith({
//     String? username,
//     String? password,
//     bool? fetching,
//   }) {
//     return SignInState(
//         username: username ?? this.username,
//         password: password ?? this.password,
//         fetching: fetching ?? this.fetching);
//   }

//   @override
//   // TODO: implement props
//   List<Object?> get props => [username, password, fetching];
// }
