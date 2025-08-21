import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:clothes_app/services/token_service.dart';

import '../models/token.dart';

class TokenManager{
  static TokenManager? _instance;
  static TokenManager get instance{
    _instance ??= TokenManager._();
    return _instance!;
  }

  String accessToken = "";
  String refreshToken = "";
  String uid = "";
  bool isRefreshing = false;
  Completer<void>? completer;

  TokenManager._();

  Future<String> getAccessToken() async{
    if (isTokenExpired() && !isRefreshing){
      debugPrint("Token has expired, refreshing access token.");
      completer = Completer<void>();
      isRefreshing = true;
      await renewAccessToken();
      isRefreshing = false;
      completer?.complete();
    }

    if (isRefreshing){
      debugPrint("Already refreshing access token, waiting for it to complete.");
      await completer?.future;
    }
    return accessToken;
  }

  bool isTokenExpired(){
    return JwtDecoder.isExpired(accessToken);
  }

  Future<void> renewAccessToken() async{
    final Token token = await TokenServices.getNewAccessToken(refreshToken);
    setToken(token);
  }

  void setToken(Token token){
    accessToken = token.accessToken;
    refreshToken = token.refreshToken;
    uid = token.uid;
  }

  void reset(){
    accessToken = "";
    refreshToken = "";
    uid = "";
  }

  void expireAccessToken(){
    accessToken = "";
  }
}