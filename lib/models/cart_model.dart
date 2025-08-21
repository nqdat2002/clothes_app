import 'package:clothes_app/models/product_detail_model.dart';

class CartModel {
  final String userId;
  List<ProductDetailsModel> products;

  CartModel({
    required this.userId,
    required this.products,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      userId: json['userId'],
      products: List<ProductDetailsModel>.from(
        json['products'].map(
          (product) => ProductDetailsModel.fromJson(product),
        ),
      ),
    );
  }
}