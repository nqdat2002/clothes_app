import 'dart:convert';
import 'package:clothes_app/helpers/constants.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class AddressService {
  Future<List<String>> getUserAddress() async {
    final uri = Uri.parse('$baseAPI/address/getaddress');
    final response = await http.get(
      uri,
      headers: defaultHeaders,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['data'] is List) {
        return List<String>.from(data['data']);
      }
    }
    return [];
  }

  Future<bool> addUserAddress(String newAddress) async {
    final uri = Uri.parse('$baseAPI/address/add');
    final response = await http.post(
      uri,
      headers: defaultHeaders,
      body: json.encode({'address': newAddress}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final errorMessage = json.decode(response.body)['message'];
      if (kDebugMode) {
        print('Error: $errorMessage');
      }
      return false;
    }
  }

  Future<bool> updateUserAddress(int index, String newAddress) async {
    final uri = Uri.parse('$baseAPI/address/update');
    final response = await http.put(
      uri,
      headers: defaultHeaders,
      body: json.encode({'index': index, 'address': newAddress}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final errorMessage = json.decode(response.body)['message'];
      if (kDebugMode) {
        print('Error: $errorMessage');
      }
      return false;
    }
  }

  Future<bool> deleteAddress(int index) async {
    final uri = Uri.parse('$baseAPI/address/delete');
    final response = await http.delete(
      uri,
      headers: defaultHeaders,
      body: json.encode({'index': index}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final errorMessage = json.decode(response.body)['message'];
      if (kDebugMode) {
        print('Error: $errorMessage');
      }
      return false;
    }
  }
}
