import 'dart:convert';

import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  Future<List<ProductModel>> getProducts() async {
    final uri = Uri.parse('$baseAPI/product/all');
    final response = await http.get(
      uri,
      headers: defaultHeaders,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> mp = data['data'];
      return mp.map((e) => ProductModel.fromJson(e)).toList();
    }
    return [];
  }

  Future <ProductModel> getOne(String id) async{
    final uri = Uri.parse('$baseAPI/product/getone/$id');
    final response = await http.get(
      uri,
      headers: defaultHeaders,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      dynamic product = data['data'];
      return ProductModel.fromJson(product);
    }
    return ProductModel(productId: "", image: "", name: "", description: "", price: 0, discountpercent: 0, status: false);  
  }
}