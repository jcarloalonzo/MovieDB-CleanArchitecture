// import 'package:flutter/foundation.dart';

// // * está clase va a notificar a la vista.
// //  esto es para que sea amigable con pruebas unitarias

// class SignInController extends ChangeNotifier {
//   final SignInState _state =
//       SignInState(username: '', password: '', fetching: false);


      

//   String _username = '', _password = '';
//   bool _fetching = false, _mounted = true;

//   String get username => _username;
//   String get password => _password;
//   bool get fetching => _fetching;
//   bool get mounted => _mounted;

//   void onUserNameChanged(String text) {
//     _username = text.trim();
//   }

//   void onPasswordChanged(String text) {
//     _password = text.replaceAll(' ', '');
//   }

//   void onFetchingChanged(bool value) {
//     _fetching = value;
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     print('✔ DISPOSE- BLOC----');

//     super.dispose();
//     _mounted = false;
//   }
// }

// class SignInState {
//   SignInState(
//       {required this.username, required this.password, required this.fetching});

//   final String username, password;
//   final bool fetching;
// }
