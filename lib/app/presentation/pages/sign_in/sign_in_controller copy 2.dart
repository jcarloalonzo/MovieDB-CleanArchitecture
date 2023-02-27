// import '../../../domain/either/either.dart';
// import '../../../domain/enums.dart';
// import '../../../domain/models/user/user.dart';
// import '../../../domain/repositories/authentication_repository.dart';
// import '../../global/state_notifier.dart';
// import 'sign_in_state.dart';

// // * está clase va a notificar a la vista.
// //  esto es para que sea amigable con pruebas unitarias

// class SignInController extends StateNotifier<SignInState> {
//   SignInController(
//     super.state, {
//     required this.authenticationRepository,
//   });

//   final AuthenticationRepository authenticationRepository;

//   // SignInState _state = SignInState(username: '', password: '', fetching: false);

//   void onUserNameChanged(String text) {
//     // _state = SignInState(
//     //     username: text.trim().toLowerCase(),
//     //     password: _state.password,
//     //     fetching: _state.fetching);

//     //
//     // _state = _state.copywith(username: text.trim().toLowerCase());
//     onlyUpdate(
//       state.copywith(
//         username: text.trim().toLowerCase(),
//       ),
//     );
//   }

//   void onPasswordChanged(String text) {
//     onlyUpdate(
//       state.copywith(
//         password: text.replaceAll(' ', ''),
//       ),
//     );
//   }

//   Future<Either<SignInFailure, User>> submit() async {
//     state = state.copywith(fetching: true);
//     final result =
//         await authenticationRepository.signIn(state.username, state.password);
//     result.when(
//       (failure) => state = state.copywith(fetching: false),
//       (_) => null,
//     );
//     return result;
//   }
// }
