import 'dart:async';
import 'dart:convert';
import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/helpers/token_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../models/token.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final _controller = StreamController<AuthenticationStatus>();
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> login({required String email, required String password}) async {
    if (kDebugMode) {
      print('attempting login');
    }

    final uri = Uri.parse('$baseAPI/auth/login');
    final response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // if (kDebugMode) {
      //   print(data['success']);
      // }
      if (data['success'] == true) {
        final dynamic dataFrameToken = data['token'];
        // print(dataFrameToken['idToken']);
        TokenManager.instance.setToken(Token(
            accessToken: dataFrameToken['idToken'],
            refreshToken: dataFrameToken['refreshToken'],
            uid: dataFrameToken['localId']));
        _controller.add(AuthenticationStatus.authenticated);
      } else {
        _controller.add(AuthenticationStatus.unauthenticated);
      }
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  Future<void> signup({required String email, required String password}) async {
    if (kDebugMode) {
      print('waiting signup');
    }

    final uri = Uri.parse('$baseAPI/auth/register');
    final response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data['success']);
      }
    } else {
      if (kDebugMode) {
        print("Error on Register");
      }
    }
  }

  void logout() {
    _controller.add(AuthenticationStatus.unauthenticated);
    TokenManager.instance.reset();
  }

  void dispose() => _controller.close();
}
