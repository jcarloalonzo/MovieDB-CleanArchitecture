import '../../state_notifier.dart';
import 'sign_in_state.dart';

// * está clase va a notificar a la vista.
//  esto es para que sea amigable con pruebas unitarias

class SignInController extends StateNotifier<SignInState> {
  SignInController(super.state);

  // SignInState _state = SignInState(username: '', password: '', fetching: false);

  void onUserNameChanged(String text) {
    // _state = SignInState(
    //     username: text.trim().toLowerCase(),
    //     password: _state.password,
    //     fetching: _state.fetching);

    //
    // _state = _state.copywith(username: text.trim().toLowerCase());
    onlyUpdate(
      state.copywith(
        username: text.trim().toLowerCase(),
      ),
    );
  }

  void onPasswordChanged(String text) {
    onlyUpdate(
      state.copywith(
        password: text.replaceAll(' ', ''),
      ),
    );
  }

  void onFetchingChanged(bool value) {
    state = state.copywith(fetching: value);
  }
}
