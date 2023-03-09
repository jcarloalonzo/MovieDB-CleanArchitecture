import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../routes/routes.dart';
import '../sign_in_controller.dart';

class SubmitButtom extends StatelessWidget {
  const SubmitButtom({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Provider.of(context);
    if (controller.state.fetching) {
      return const CircularProgressIndicator();
    }

    return MaterialButton(
      onPressed: () {
        final isValid = Form.of(context).validate();
        if (isValid) {
          _submit(context);
        }
      },
      color: Colors.blue,
      child: const Text('Sign in'),
    );
  }

  Future _submit(BuildContext context) async {
    final bloc = context.read<SignInController>();
    final result = await bloc.submit();
    if (!bloc.mounted) return;
    print(result);
    print(result.toString());
    result.maybeWhen(
      orElse: () {
        print('que fueeeee');
      },
      left: (failure) {
        final message = failure.when(
          network: () => 'Network Error',
          notFound: () => 'Not found',
          unauthorized: () => 'Unauthorized',
          unknow: () => 'Error',
          notVerified: () => 'Email not verifies',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      },
      right: (_) => Navigator.pushReplacementNamed(context, Routes.home),
    );
  }
}
