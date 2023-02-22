import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class InternetChecker {
  Future<bool> hasInternet() async {
    try {
      if (kIsWeb) {
        final response = await get(Uri.parse('8.8.8.8'));

// * CON ESTE METODO PODEMOS SABER SI TENEMOS INTERNET EN WEB
        print(response.statusCode);
        print(response.statusCode == 200);
        return response.statusCode == 200;
      }

      final list = await InternetAddress.lookup('google.com');
      if (list.isNotEmpty && list.first.rawAddress.isNotEmpty) {
        //
        return true;
      }
      //
      print('ok');
      return false;
    } catch (e) {
      print('cagado');

      print(e);
      return false;
    }
  }
}
