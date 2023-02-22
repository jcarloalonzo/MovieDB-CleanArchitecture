import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../main.dart';
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
    final injector = Injector.of(context);
    // ConnectivityRepository connectivityRepository =
    final connectivityRepository = injector.connectivityRepository;
    //     ConnectivityRepositoryImpl();

    final hasInternet = await connectivityRepository.hasInternet();

    print('has intenret: ->>> $hasInternet');

    //
    //
    if (hasInternet) {
      final authenticationRepository = injector.authenticationRepository;
      final isSignedIn = await authenticationRepository.isSignedIn;
      if (isSignedIn) {
        final user = await authenticationRepository.getUserData();
        if (mounted) {
          if (user != null) {
            //home
            _goTo(Routes.home);
          } else {
            // sign in
            _goTo(Routes.signin);
          }
        }
      } else if (mounted) {
        _goTo(Routes.signin);
      }
    } else {
      _goTo(Routes.offline);
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
