import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_failure.freezed.dart';

@freezed
class SignInFailure with _$SignInFailure {
  factory SignInFailure.network() = SignInFailureNetwork;
  factory SignInFailure.notFound() = SignInFailureNotFound;
  factory SignInFailure.unauthorized() = SignInFailureUnauthorized;
  factory SignInFailure.unknow() = SignInFailureUnknown;
}



// abstract class SignInFailure {}

// class Network extends SignInFailure {}

// class NotFound extends SignInFailure {}

// class Unauthorized extends SignInFailure {}

// class Unknown extends SignInFailure {}



// 
// 
// 
// 

// enum SignInFailure {
//   notFound,
//   unauthorized,
//   unknown,
//   network,
// }
