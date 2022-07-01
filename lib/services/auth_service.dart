import 'dart:convert';
import 'dart:developer';
import 'package:chat/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chat/global/env.dart';
import 'package:chat/models/user.dart';
import 'package:chat/models/responses/login_response.dart';
import 'package:chat/models/responses/signup_response.dart';

class AuthService with ChangeNotifier {
  User? _currentUser;
  User? get currentUser => _currentUser;

  final _storage = const FlutterSecureStorage();

  /// Static getters for token.
  static Future<String?> getToken() async {
    const storage = FlutterSecureStorage();

    return await storage.read(key: 'token');
  }

  // static Future deleteToken() async {
  //   const storage = FlutterSecureStorage();

  //   await storage.delete(key: 'token');
  // }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    if (token == null) {
      return false;
    }

    try {
      final Uri url = Uri.tryParse('${Environment.apiUrl}/login/renew')!;

      final res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-token': token,
        },
      );

      final loginRes = loginResponseFromJson(res.body);

      if (res.statusCode == 200) {
        _currentUser = loginRes.user;

        _storeToken(loginRes.token!);

        return true;
      } else {
        logOut();

        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future login(String email, String password) async {
    final data = {
      'email': email.trim(),
      'password': password.trim(),
    };

    try {
      final Uri url = Uri.tryParse('${Environment.apiUrl}/login')!;

      final res = await http.post(
        url,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final loginRes = loginResponseFromJson(res.body);

      if (res.statusCode == 200) {
        _currentUser = loginRes.user;

        _storeToken(loginRes.token!);

        return true;
      } else {
        throw Exception(loginRes.code);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future createAccountWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final data = {
      'name': name.trim(),
      'email': email.trim(),
      'password': password.trim(),
    };

    try {
      final Uri url = Uri.tryParse('${Environment.apiUrl}/login/new')!;

      final res = await http.post(
        url,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final signUpRes = signUpResponseFromJson(res.body);

      if (res.statusCode == 200) {
        _currentUser = signUpRes.user;

        _storeToken(signUpRes.token!);

        return true;
      } else {
        throw Exception(signUpRes.code);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future _storeToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logOut() async {
    return await _dropToken();
  }

  Future _dropToken() async => await _storage.delete(key: 'token');
}
