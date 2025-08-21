import 'dart:convert';

import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/models/product_detail_variant.dart';
import 'package:http/http.dart' as http;

class ProductDetailService {
  Future<ProductDetailVariant> getOneVariant(String productId) async {
    final uri = Uri.parse('$baseAPI/productdetail/$productId');
    final response = await http.get(
      uri,
      headers: defaultHeaders,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ProductDetailVariant.fromJson(data);
    }
    return ProductDetailVariant(
        sizeIds: [],
        colorIds: [],
        currentQuantity: 0);
  }
}
