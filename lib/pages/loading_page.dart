import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';

class LoadingPage extends StatelessWidget {
  static const String routeName = 'loading';

  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return const Center(
            child: Text('Loading...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final bool isLoggedIn = await context.read<AuthService>().isLoggedIn();

    if (isLoggedIn) {
      // TODO: Connect to Socket server.
      Navigator.of(context).pushReplacementNamed(UsersPage.routeName);
      // Navigator.of(context).pushReplacement(
      //   PageRouteBuilder(pageBuilder: (_, __, ___) => const UsersPage()),
      // );
    } else {
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    }
  }
}
