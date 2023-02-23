import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../../domain/enums.dart';
import '../../../routes/routes.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _username = '', _password = '';

  bool _fetching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            // *ABSORBPOINTER ES PARA QUE NO SE PUEDA USAR
            child: AbsorbPointer(
              absorbing: _fetching,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (text) {
                      setState(() {
                        _username = text.trim().toLowerCase();
                      });
                    },
                    decoration: const InputDecoration(hintText: 'Username'),
                    validator: (text) {
                      text = text?.trim().toLowerCase() ?? '';
                      if (text.isEmpty) {
                        return 'Invalid Username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (text) {
                      setState(() {
                        _password = text.replaceAll(' ', '').toLowerCase();
                      });
                    },
                    validator: (text) {
                      text = text?.replaceAll(' ', '').toLowerCase() ?? '';
                      if (text.length < 4) {
                        return 'Invalid Password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(height: 20),
                  Builder(builder: (context) {
                    if (_fetching) return const CircularProgressIndicator();
                    // *USAMOS UN BUILDER PORQUE EL FORM OF -- CONTEXT -- EL CONTEXTO DEBE SER HIO DE FORM

                    return MaterialButton(
                      onPressed: () {
                        final isValid = Form.of(context).validate();
                        if (isValid) {
                          //
                          _submit(context);
                        }
                      },
                      color: Colors.blue,
                      child: const Text('Sign in'),
                    );
                  }),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     const secureStorage = FlutterSecureStorage();
                  //     final sessionId = await secureStorage.read(key: _key);
                  //     print(sessionId);
                  //     //
                  //     //
                  //   },
                  //   child: const Text('read'),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     const secureStorage = FlutterSecureStorage();
                  //     await secureStorage.write(
                  //         key: _key,
                  //         value: 'Hola hola prueba xd{Hola:pruebaxd:}');
                  //     //
                  //     //
                  //   },
                  //   child: const Text('write'),
                  // ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     const secureStorage = FlutterSecureStorage();
                  //     await secureStorage.delete(key: _key);

                  //     //
                  //     //
                  //   },
                  //   child: const Text('delete'),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // final String _key = 'sessionID';

  Future _submit(BuildContext context) async {
    setState(() {
      _fetching = true;
    });

    final result = await Injector.of(context)
        .authenticationRepository
        .signIn(_username, _password);

// * VALIDA SI ESTÁ RENDERIZADO
    print(mounted);
    if (!mounted) {
      return;
    }

    result.when((failure) {
      //
      setState(() {
        _fetching = false;
      });

      final message = {
        SignInFailure.notFound: 'Not Found',
        SignInFailure.unauthorized: 'Invalid Password',
        SignInFailure.unknown: 'Error',
      }[failure];

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message!),
        ),
      );
    }, (user) {
      Navigator.pushReplacementNamed(context, Routes.home);
      //
    });
  }
}
