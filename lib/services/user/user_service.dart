import 'dart:convert';
import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/models/user_profile.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class UserServices{
  Future<UserProfile> getUserProfile() async {
    final uri = Uri.parse('$baseAPI/auth/user-profile');
    final response = await http.get(
      uri,
      headers: defaultHeaders,
    );

    if (response.statusCode == 200) {
      dynamic mp = jsonDecode(response.body);
      return UserProfile.fromJson(mp);
    }
    return UserProfile(displayName: "Error", email: "Error", phoneNumber: "Error", photoURL: "Error", emailVerified: false);
  }

  Future <bool> updateUserProfile(UserProfile newUserInfor) async {
    try {
      final response = await http.put(
        Uri.parse('$baseAPI/auth/update-profile'),
        headers: defaultHeaders,
        body: json.encode({
          "displayName": newUserInfor.displayName,
          "phoneNumber": newUserInfor.phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return true;
        } else {
          if (kDebugMode) {
            print("API error: ${data['message']}");
          }
          return false;
        }
      } else {
        if (kDebugMode) {
          print("HTTP error: ${response.statusCode} - ${response.reasonPhrase}");
        }
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}