import 'package:clothes_app/models/product_model.dart';

class ProductDetailsModel {
  final String sizeId, colorId;
  final ProductModel product;
  int quantity;
  bool isSelected;

  ProductDetailsModel({
    required this.product,
    required this.sizeId,
    required this.colorId,
    required this.quantity,
    this.isSelected = false, 
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      product: ProductModel.fromJson(json['product']) ,
      sizeId: json['sizeId'] as String? ?? '',
      colorId: json['colorId'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
      isSelected: false,
    );
  }
  
  ProductDetailsModel copyWith({
    ProductModel? product,
    String? sizeId,
    String? colorId,
    int? quantity,
    bool? isSelected,
  }) {
    return ProductDetailsModel(
      product: product ?? this.product,
      sizeId: sizeId ?? this.sizeId,
      colorId: colorId ?? this.colorId,
      quantity: quantity ?? this.quantity,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'sizeId': sizeId,
      'colorId': colorId,
      'quantity': quantity,
    };
  }

  static List<ProductDetailsModel> parseList(dynamic jsonList) {
    if (jsonList == null || jsonList is! List || jsonList.isEmpty) {
      return [];
    }
    return jsonList.map((json) => ProductDetailsModel.fromJson(json)).toList();
  }
}