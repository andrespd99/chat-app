import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/signup_page.dart';
import 'package:chat/pages/users_page.dart';

import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  ChatPage.routeName: (_) => const ChatPage(),
  UsersPage.routeName: (_) => const UsersPage(),
  LoginPage.routeName: (_) => const LoginPage(),
  SignupPage.routeName: (_) => const SignupPage(),
  LoadingPage.routeName: (_) => const LoadingPage(),
};
