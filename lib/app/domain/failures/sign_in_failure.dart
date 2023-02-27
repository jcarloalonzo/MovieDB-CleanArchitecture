abstract class SignInFailure {}

class Network extends SignInFailure {}

class NotFound extends SignInFailure {}

class Unauthorized extends SignInFailure {}

class Unknown extends SignInFailure {}



// enum SignInFailure {
//   notFound,
//   unauthorized,
//   unknown,
//   network,
// }
