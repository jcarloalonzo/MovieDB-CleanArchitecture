import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/repositories/authentication_repository.dart';
import '../../global/controller/session_controller.dart';
import '../../routes/routes.dart';
import 'sign_in_controller.dart';
import 'sign_in_state.dart';

class SignInPage extends StatelessWidget {
  const SignInPage._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInController(
// nos pide pasar el estado inicial
          const SignInState(),
          authenticationRepository: context.read<AuthenticationRepository>()

          // apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
          // localRepositoryInterface: context.read<LocalRepositoryInterface>(),
          ),
      builder: (_, __) => const SignInPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            // *ABSORBPOINTER ES PARA QUE NO SE PUEDA USAR
            child: Builder(builder: (context) {
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
    final userBloc = Provider.of<SessionController>(context, listen: false);
    final result = await bloc.submit();
    if (!bloc.mounted) return;

    result.when(
      left: (failure) {
        final message = failure.when(
            network: () => 'Network Error',
            notFound: () => 'Not found',
            unauthorized: () => 'Unauthorized',
            unknow: () => 'Error');

        // ! se reemplaza con freezed funcional
        // result.when(
        //     //
        //     (failure) {
        //   final message = () {
        //     if (failure is NotFound) {
        //       return 'Not Found';
        //     }
        //     if (failure is Unauthorized) {
        //       return 'Invalid Password';
        //     }
        //     if (failure is Network) {
        //       return 'Network Error';
        //     }
        //     return 'Error';
        //   }();

        // final message = {
        //   SignInFailure.notFound: 'Not Found',
        //   SignInFailure.unauthorized: 'Invalid Password',
        //   SignInFailure.unknown: 'Error',
        //   SignInFailure.network: 'Network error',
        // }[failure];

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      },
      right: (user) {
        userBloc.setUser(user);
        //
        Navigator.pushReplacementNamed(context, Routes.home);
      },
    );
  }
}
