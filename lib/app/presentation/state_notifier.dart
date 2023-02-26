// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';

abstract class StateNotifier<State> extends ChangeNotifier {
  //
  StateNotifier(this._state);

  State _state;
  State get state => _state;

  set state(State newState) {
    _update(newState);
  }

  bool _mounted = true;
  bool get mounted => _mounted;

  void onlyUpdate(State newState) {
    _update(newState, notify: false);
  }

  void _update(
    State newState, {
    bool notify = true,
  }) {
    if (_state == newState) return;

    _state = newState;
    if (notify) notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _mounted = false;
    super.dispose();
  }
}
