import 'package:chat/functions/functions.dart';
import 'package:chat/pages/users_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/terms_and_conditions_button.dart';
import 'package:flutter/material.dart';

import 'package:chat/consts.dart';
import 'package:chat/validators.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/auth_labels.dart';
import 'package:chat/widgets/elevated_text_input.dart';
import 'package:provider/provider.dart';

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
                      SizedBox(height: Consts.padding),
                      Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: Consts.padding * 2),
                      _Form(),
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
  String get email => _emailController.text;

  final _passwordController = TextEditingController();
  String get password => _passwordController.text;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ElevatedTextField(
            TextFormField(
              controller: _emailController,
              onChanged: (value) => setState(() {}),
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
              onChanged: (value) => setState(() {}),
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
          const SizedBox(height: Consts.padding * 1.25),
          _LoginButton(
            email: email,
            password: password,
          ),
        ],
      ),
    );
  }
}

class _LoginButton extends StatefulWidget {
  final String email;
  final String password;

  const _LoginButton({
    required this.email,
    required this.password,
    Key? key,
  }) : super(key: key);

  @override
  State<_LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<_LoginButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text(
        'Log in',
        style: TextStyle(fontSize: 16.0),
      ),
      onPressed: _isLoading
          ? null
          : () {
              if (Form.of(context)!.validate()) {
                setState(() {
                  _isLoading = true;
                });
                context
                    .read<AuthService>()
                    .login(widget.email, widget.password)
                    .then((value) {
                  Navigator.pushReplacementNamed(context, UsersPage.routeName);
                  setState(() {
                    _isLoading = false;
                  });
                }).catchError((error) {
                  setState(() {
                    _isLoading = false;
                  });
                  showCustomDialog(
                    context,
                    subtitle: error.toString(),
                  );
                });
              }
            },
    );
  }
}
