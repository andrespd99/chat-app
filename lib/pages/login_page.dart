import 'package:chat/widgets/terms_and_conditions_button.dart';
import 'package:flutter/material.dart';

import 'package:chat/consts.dart';
import 'package:chat/validators.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/auth_labels.dart';
import 'package:chat/widgets/elevated_text_input.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const AuthState authState = AuthState.login;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: IntrinsicHeight(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(Consts.padding),
                  child: Column(
                    // shrinkWrap: true,
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      SizedBox(height: Consts.padding * 2),
                      Logo(),
                      SizedBox(height: Consts.padding * 2),
                      _Form(),
                      SizedBox(height: Consts.padding * 1.25),
                      _LoginButton(),
                      SizedBox(height: Consts.padding * 2),
                      AuthLabels(authState),
                      SizedBox(height: Consts.padding * 3),
                      Spacer(),
                      TermsAndConditionsTextButton()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ElevatedTextField(
            TextFormField(
              controller: _emailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => Validators.checkEmail(value),
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.mail_outline),
                errorMaxLines: 10,
              ),
            ),
          ),
          const SizedBox(height: Consts.padding),
          ElevatedTextField(
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  (value!.isEmpty) ? 'Enter your password' : null,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline_rounded),
                errorMaxLines: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text(
        'Log in',
        style: TextStyle(fontSize: 16.0),
      ),
      onPressed: () {},
    );
  }
}
