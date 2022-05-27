import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:chat/consts.dart';
import 'package:chat/routes/routes.dart';
import 'package:chat/pages/users_page.dart';

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
      initialRoute: UsersPage.routeName,
      routes: appRoutes,
      theme: ThemeData(
          textTheme: GoogleFonts.ptSansTextTheme(),
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.teal.shade300,
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
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: Consts.padding * 1.5,
              vertical: Consts.padding * 0.6,
            ),
            shape: const StadiumBorder(),
            primary: Colors.black,
          ))),
    );
  }
}
