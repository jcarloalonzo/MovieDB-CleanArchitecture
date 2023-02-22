import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../domain/repositories/connecivity_repository.dart';
import '../../services/remote/internet_checker.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
// *ESTO SE LE CONOCE COMO INYECCION DE DEPENDENCIAS Y PERMITE QUE NUESTRO CODIGO SEA TESTEABLE
  final Connectivity _connectivity;
  final InternetChecker _internetChecker;
  ConnectivityRepositoryImpl(this._connectivity, this._internetChecker);
  //

  @override
  Future<bool> hasInternet() async {
    final result = await _connectivity.checkConnectivity();
    print(result);
    if (result == ConnectivityResult.none) {
      print('no conectado a internet');
      return false;
    }
    // el package connectivity plus no valida si hay conexion con internet .

// lo separamos para que pueda testearse
    return _internetChecker.hasInternet();
  }

  //EL ANTERIOR
//   @override
//   Future<bool> hasInternet() async {
//     // await Future.delayed(const Duration(seconds: 2));
// // asi como está ahorita este codigo no puede ser testeado
//     final result = await Connectivity().checkConnectivity();
//     print(result);
//     if (result == ConnectivityResult.none) {
//       print('no conectado a internet');
//       return false;
//     }
//     return Future.value(true);
//   }
}
