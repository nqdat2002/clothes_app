
import 'dart:convert';
import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/helpers/token_manager.dart';

import '../../models/token.dart';
import 'package:http/http.dart' as http;

class TokenServices{
   static Future<Token> getNewAccessToken(String refreshToken) async {
    final dynamic response = await http.post(
      Uri.parse('$baseAPI/auth/refresh-token'),
      headers: {"Authorization": 'Bearer: ${TokenManager.instance.getAccessToken()}'},
      body: {
        "refreshToken": refreshToken,
      },
    );
    return Token.fromJson(jsonDecode(response.body));
  }
}