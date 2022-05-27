import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/users_page.dart';
import 'package:chat/routes/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      builder: (context, child) => Material(
        child: child,
      ),
      initialRoute: LoginPage.routeName,
      routes: appRoutes,
      theme: ThemeData(
        primaryColor: Colors.tealAccent.shade400,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              secondary: Colors.black,
              background: const Color(0xffF2F2F2),
            ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
