import 'package:flutter/material.dart';

import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/signup_page.dart';

enum AuthState { signUp, login }

class AuthLabels extends StatelessWidget {
  final AuthState authState;

  const AuthLabels(this.authState, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (authState == AuthState.login) {
      return Column(
        children: [
          const Text(
            "Not registered yet?",
            style: TextStyle(
              fontWeight: FontWeight.w200,
            ),
          ),
          TextButton(
            child: const Text('Create an account'),
            onPressed: () =>
                Navigator.popAndPushNamed(context, SignupPage.routeName),
          ),
        ],
      );
    }

    return Column(
      children: [
        const Text(
          'Already have an account?',
          style: TextStyle(
            fontWeight: FontWeight.w200,
          ),
        ),
        TextButton(
          child: const Text('Log in'),
          onPressed: () =>
              Navigator.popAndPushNamed(context, LoginPage.routeName),
        ),
      ],
    );
  }
}
