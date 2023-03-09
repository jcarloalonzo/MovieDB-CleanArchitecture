import '../../../domain/either/either.dart';
import '../../../domain/failures/sign_in/sign_in_failure.dart';
import '../../../domain/models/user/user.dart';
import '../../../domain/repositories/authentication_repository.dart';
import '../../global/controller/favorites/favorites_controller.dart';
import '../../global/controller/session_controller.dart';
import '../../global/state_notifier.dart';
import 'sign_in_state.dart';

// * está clase va a notificar a la vista.
//  esto es para que sea amigable con pruebas unitarias

class SignInController extends StateNotifier<SignInState> {
  SignInController(
    super.state, {
    required this.authenticationRepository,
    required this.sessionController,
    required this.favoritesController,
  });

  final AuthenticationRepository authenticationRepository;

  final SessionController sessionController;
  final FavoritesController favoritesController;

  // SignInState _state = SignInState(username: '', password: '', fetching: false);

  void onUserNameChanged(String text) {
    // _state = SignInState(
    //     username: text.trim().toLowerCase(),
    //     password: _state.password,
    //     fetching: _state.fetching);

    //
    // _state = _state.copywith(username: text.trim().toLowerCase());
    onlyUpdate(
      state.copyWith(
        username: text.trim().toLowerCase(),
      ),
    );
  }

  void onPasswordChanged(String text) {
    onlyUpdate(
      state.copyWith(
        password: text.replaceAll(' ', ''),
      ),
    );
  }

  Future<Either<SignInFailure, User>> submit() async {
    state = state.copyWith(fetching: true);
    final result =
        await authenticationRepository.signIn(state.username, state.password);

    result.when(
      left: (_) {
        //
        return state = state.copyWith(fetching: false);
      },
      right: (user) {
        //
        sessionController.setUser(user);
        favoritesController.init();
      },
    );
    return result;
  }
}
