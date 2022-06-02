import 'dart:ui';

import 'package:chat/functions/random_color.dart';

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String uid;
  final String name;
  final String email;
  final bool online;

  final Color color;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.online,
  }) : color = getRandomColor();

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      online: data['online'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'online': online,
      };
}
