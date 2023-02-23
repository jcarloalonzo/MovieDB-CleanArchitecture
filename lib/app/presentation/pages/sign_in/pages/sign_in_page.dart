import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _username = '', _password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
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
                // *USAMOS UN BUILDER PORQUE EL FORM OF -- CONTEXT -- EL CONTEXTO DEBE SER HIO DE FORM 
                Builder(
                  builder: (context) {
                    return MaterialButton(
                      onPressed: () {
                        final isValid=Form.of(context).validate();
                        if(isValid){
                          // 
                          
                        }
                      },
                      color: Colors.blue,
                      child: const Text('Sign in'),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
