import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat/services/auth_service.dart';

import 'package:chat/consts.dart';
import 'package:chat/validators.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/functions/functions.dart';
import 'package:chat/widgets/auth_labels.dart';
import 'package:chat/widgets/elevated_text_input.dart';
import 'package:chat/widgets/terms_and_conditions_button.dart';

class SignupPage extends StatelessWidget {
  static const String routeName = 'signup';

  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const AuthState authState = AuthState.signUp;

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
                        'Create account',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: Consts.padding * 2),
                      _Form(),
                      SizedBox(height: Consts.padding * 2),
                      AuthLabels(authState),
                      Spacer(),
                      TermsAndConditionsTextButton(),
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

  final _nameController = TextEditingController();
  String get name => _nameController.text;

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
              controller: _nameController,
              onChanged: (value) => setState(() {}),
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => Validators.checkName(value),
              decoration: const InputDecoration(
                labelText: 'Full name',
                prefixIcon: Icon(Icons.person_outline),
                errorMaxLines: 10,
              ),
            ),
          ),
          const SizedBox(height: Consts.padding),
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
              validator: (value) => Validators.checkPassword(value),
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline_rounded),
                errorMaxLines: 10,
              ),
            ),
          ),
          const SizedBox(height: Consts.padding * 1.25),
          _SignUpButton(
            name: name,
            email: email,
            password: password,
          ),
        ],
      ),
    );
  }
}

class _SignUpButton extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const _SignUpButton({
    required this.name,
    required this.email,
    required this.password,
    Key? key,
  }) : super(key: key);

  @override
  State<_SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<_SignUpButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text(
        'Create account',
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
                    .createAccountWithEmailAndPassword(
                      name: widget.name,
                      email: widget.email,
                      password: widget.password,
                    )
                    .then((value) {
                  setState(() {
                    _isLoading = false;
                  });
                }).catchError((error) {
                  setState(() {
                    _isLoading = false;
                  });
                  showCustomDialog(
                    context,
                    subtitle: error,
                  );
                });
              }
            },
    );
  }
}
