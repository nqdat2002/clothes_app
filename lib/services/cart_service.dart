import 'dart:convert';

import 'package:clothes_app/helpers/token_manager.dart';
import 'package:clothes_app/models/product_detail_model.dart';
import 'package:http/http.dart' as http;

import 'package:clothes_app/helpers/constants.dart';

class CartService {
  Future <List<ProductDetailsModel> > getCart() async {
    final uri = Uri.parse('$baseAPI/cart/getcart');
    final response = await http.get(
      uri,
      headers: defaultHeaders,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final cartData = data['data'];  
      List<dynamic> mp = cartData['products'];
      return mp.map((e) => ProductDetailsModel.fromJson(e)).toList();    
    }
    return [];
  }

  Future <bool> changeQuantity (String productId, String sizeId, String colorId, int quantity) async {
    final uri = Uri.parse('$baseAPI/cart/update-quantity');
    final response = await http.put(
      uri,
      headers: defaultHeaders,
      body: jsonEncode({
        'userId': TokenManager.instance.uid,
        'productId': productId,
        'sizeId': sizeId,
        'colorId': colorId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future <bool> removeProduct (String productId, String sizeId, String colorId) async {
    final uri = Uri.parse('$baseAPI/cart/remove');
    final response = await http.delete(
      uri,
      headers: defaultHeaders,
      body: jsonEncode({
        'userId': TokenManager.instance.uid,
        'productId': productId,
        'sizeId': sizeId,
        'colorId': colorId,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> addtoCart(String productId, String sizeId, String colorId, int quantity) async{
    final uri = Uri.parse('$baseAPI/cart/add-to-cart');
    final response = await http.post(
      uri,
      headers: defaultHeaders,
      body: jsonEncode({
        'userId': TokenManager.instance.uid,
        'productId': productId,
        'sizeId': sizeId,
        'colorId': colorId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}