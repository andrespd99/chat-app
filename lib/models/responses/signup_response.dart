// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/user.dart';

SignUpResponse signUpResponseFromJson(String str) =>
    SignUpResponse.fromJson(json.decode(str));

String signInResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  SignUpResponse({
    required this.ok,
    required this.msg,
    required this.code,
    this.user,
    this.token,
  });

  bool ok;
  String msg;
  String code;
  User? user;
  String? token;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        ok: json["ok"],
        msg: json["msg"],
        code: json["code"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "code": code,
        if (user != null) "user": user!.toJson(),
        if (token != null) "token": token,
      };
}
