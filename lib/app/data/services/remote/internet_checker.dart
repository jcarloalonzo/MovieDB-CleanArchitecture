import 'dart:io';

class InternetChecker {
  Future<bool> hasInternet() async {
    try {
      final list = await InternetAddress.lookup('google.com');
      if (list.isNotEmpty && list.first.rawAddress.isNotEmpty) {
        //
        return true;
      }
      //
      return false;
    } catch (e) {
      return false;
    }
  }
}
