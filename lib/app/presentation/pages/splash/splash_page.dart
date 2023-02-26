import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../domain/repositories/authentication_repository.dart';
import '../../../domain/repositories/connecivity_repository.dart';
import '../../routes/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //
    //
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        //
        _init();
      },
    );
    // _init();
  }

  _init() async {
    final routeName = await () async {
      final connectivityRepository = context.read<ConnectivityRepository>();
      final authenticationRepository = context.read<AuthenticationRepository>();

      final hasInternet = await connectivityRepository.hasInternet();

      if (!hasInternet) {
        return Routes.offline;
      }
      final isSignedIn = await authenticationRepository.isSignedIn;
      if (!isSignedIn) {
        return Routes.signin;
      }
      final user = await authenticationRepository.getUserData();

      if (user != null) {
        return Routes.home;
      } else {
        return Routes.signin;
      }
    }();

    if (mounted) {
      _goTo(routeName);
    }
  }

  void _goTo(String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // bool result = await InternetConnectionChecker().hasConnection;
                  //   print(InternetConnectionChecker().addresses);
                  // if (result == true) {
                  //   print('YAY! Free cute dog pics!');
                  // } else {
                  //   print('No internet :( Reason:');
                  // }

                  try {
                    final list =
                        await InternetAddress.lookup('www.xvideos.com');
                    if (list.isNotEmpty && list.first.rawAddress.isNotEmpty) {
                      print('INTERNEEEET');
                    } else {
                      print('NOOOOOOOOOO INTERNEEEET');
                    }
                    print('uwur');
                    await getPrices();
                    print('uwurxd');
                  } catch (e) {
                    print('FATALITIY ERRORILITTSA');

                    print(e);
                  }

                  //
                  //
                },
                child: const Text('text'),
              ),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Future getPrices() async {
    try {
      print('init');

      final response =
          await http.get(Uri.parse('https://api.coincap.io/v2/assets'));
      print('finish');

      print(response);
      // print(2 + 2);
    } catch (e) {
      print('eeeeeeeeeeeeeeeeeeeeee');
      print(e);
    }
  }
}
