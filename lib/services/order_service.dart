import 'dart:convert';

import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/models/order_detail_model.dart';
import 'package:clothes_app/models/product_detail_model.dart';
import 'package:http/http.dart' as http;

class OrderService {
  Future<String> createOrder(List<ProductDetailsModel> selectedProduct, String selectedAddress) async{
    final uri = Uri.parse('$baseAPI/order/create');
    final response = await http.post(
      uri,
      headers: defaultHeaders,
      body: jsonEncode(<String, dynamic>{
        'selectedProducts': selectedProduct,
        'address': selectedAddress
      })
    );

    if (response.statusCode == 201){
      final data = jsonDecode(response.body);
      return data['orderId'];
    }
    return "";
    // return true;
  }

  Future<String> createLinkPayment(String orderId, double amount) async{
    final uri = Uri.parse('$baseAPI/payment/create');
    final response = await http.post(
      uri,
      headers: defaultHeaders,
      body: jsonEncode(<String, dynamic>{
        "orderId": orderId,
        "amount": amount
      })
    );

    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
      return data['payUrl'];
    }
    return "https://www.google.com";
  }

  Future<bool> checkStatusPayment(String orderId) async{
    final uri = Uri.parse('$baseAPI/payment/transaction-status');
    final response = await http.post(
      uri,
      headers: defaultHeaders,
      body: jsonEncode(<String, dynamic>{
        "orderId": orderId,
      })
    );

    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
      return data['resultCode'] == 0;
    }
    return false;
  }
  

  Future<List<OrderDetailModel>> getOrders() async{
    List<OrderDetailModel> list = [];
     final uri = Uri.parse('$baseAPI/order/getorders');
    final response = await http.get(
      uri,
      headers: defaultHeaders,
    );

    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
      final orders = data['data'] as List;
      list = orders.map((order) => OrderDetailModel.fromJson(order)).toList();
    }
    else {
      throw Exception('Failed to load orders');
    }
    return list;
  }
}