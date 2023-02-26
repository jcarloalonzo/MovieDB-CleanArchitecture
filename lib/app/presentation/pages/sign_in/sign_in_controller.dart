import 'package:flutter/foundation.dart';

import 'sign_in_state.dart';

// * está clase va a notificar a la vista.
//  esto es para que sea amigable con pruebas unitarias

class SignInController extends ChangeNotifier {
  // SignInState _state = SignInState(username: '', password: '', fetching: false);
  SignInState _state = SignInState();

  SignInState get state => _state;

  bool _mounted = true;

  bool get mounted => _mounted;

  void onUserNameChanged(String text) {
    // _state = SignInState(
    //     username: text.trim().toLowerCase(),
    //     password: _state.password,
    //     fetching: _state.fetching);
    _state = _state.copywith(username: text.trim().toLowerCase());
  }

  void onPasswordChanged(String text) {
    _state = _state.copywith(password: text.replaceAll(' ', ''));
  }

  void onFetchingChanged(bool value) {
    _state = _state.copywith(fetching: value);
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('✔ DISPOSE- BLOC----');

    super.dispose();
    _mounted = false;
  }
}
