import 'package:chat/consts.dart';
import 'package:chat/widgets/elevated_text_input.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heigh = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.vertical;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: Consts.padding),
          height: heigh,
          child: ListView(
            // shrinkWrap: true,
            children: [
              const SizedBox(height: Consts.padding * 2),
              const _Logo(),
              const SizedBox(height: Consts.padding * 2),
              _Form(),
              const SizedBox(height: Consts.padding * 1.25),
              ElevatedButton(
                child: const Text(
                  'Log in',
                  style: TextStyle(fontSize: 16.0),
                ),
                onPressed: () {},
              ),
              const SizedBox(height: Consts.padding * 2),
              const _Labels(),
              const SizedBox(height: Consts.padding * 3),
              TextButton(
                child: const Text('Términos y condiciones de uso'),
                onPressed: () {},
                style: TextButton.styleFrom(
                  primary: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Image(
            image: AssetImage('assets/logo.png'),
            fit: BoxFit.cover,
            height: 100.0,
          ),
          SizedBox(height: 20.0),
          Text(
            'Woosh!',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Form extends StatefulWidget {
  _Form({Key? key}) : super(key: key);

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
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.mail_outline),
              ),
            ),
          ),
          const SizedBox(height: Consts.padding),
          ElevatedTextField(
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Labels extends StatelessWidget {
  const _Labels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '¿No tienes una cuenta?',
          style: TextStyle(
            fontWeight: FontWeight.w200,
          ),
        ),
        TextButton(
          child: const Text('Registrarse'),
          onPressed: () {},
        ),
      ],
    );
  }
}
