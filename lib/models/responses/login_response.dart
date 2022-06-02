// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/user.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.ok,
    this.user,
    this.token,
    this.code,
  });

  final bool ok;
  final User? user;
  final String? token;
  final String? code;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        token: json["token"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        if (user != null) "user": user!.toJson(),
        "code": code,
        "token": token,
      };
}
