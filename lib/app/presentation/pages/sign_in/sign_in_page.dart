import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/enums.dart';
import '../../../domain/repositories/authentication_repository.dart';
import '../../routes/routes.dart';
import 'sign_in_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInController(
          // apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
          // localRepositoryInterface: context.read<LocalRepositoryInterface>(),
          ),
      builder: (_, __) => const SignInPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('👀👀 BUILDER');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            // *ABSORBPOINTER ES PARA QUE NO SE PUEDA USAR
            child: Builder(builder: (context) {
              print('😜😜 Fbuilder form ');
              final bloc = context.watch<SignInController>();

              return AbsorbPointer(
                absorbing: bloc.state.fetching,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: bloc.onUserNameChanged,
                      decoration: const InputDecoration(hintText: 'Username'),
                      validator: (text) {
                        text = text?.trim() ?? '';
                        if (text.isEmpty) {
                          return 'Invalid Username';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (text) => bloc.onPasswordChanged(text),
                      validator: (text) {
                        text = text?.replaceAll(' ', '') ?? '';
                        if (text.length < 4) {
                          return 'Invalid Password';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                    const SizedBox(height: 20),
                    if (bloc.state.fetching)
                      const CircularProgressIndicator()
                    else
                      MaterialButton(
                        onPressed: () {
                          final isValid = Form.of(context).validate();
                          if (isValid) {
                            _submit(context);
                          }
                        },
                        color: Colors.blue,
                        child: const Text('Sign in'),
                      )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Future _submit(BuildContext context) async {
    final bloc = context.read<SignInController>();

    bloc.onFetchingChanged(true);

    final result = await context
        .read<AuthenticationRepository>()
        .signIn(bloc.state.username, bloc.state.password);

    print(result);
// * VALIDA SI ESTÁ RENDERIZADO

    if (!bloc.mounted) {
      return;
    }

    print(' 😊 MOUNTED === ${context.mounted}');

    result.when((failure) {
      //
      bloc.onFetchingChanged(false);

      final message = {
        SignInFailure.notFound: 'Not Found',
        SignInFailure.unauthorized: 'Invalid Password',
        SignInFailure.unknown: 'Error',
        SignInFailure.network: 'Network error',
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
    print('FINAL 😊 MOUNTED === ${context.mounted}');
  }
}
