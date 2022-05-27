import 'dart:ui';

import 'package:chat/functions/random_color.dart';

class User {
  final String id;
  final String name;
  final String email;
  final bool online;
  final Color color;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.online,
  }) : color = getRandomColor();

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      online: data['online'],
    );
  }
}
