
import 'package:clothes_app/models/product_detail_model.dart';

class OrderDetailModel {
  final List<ProductDetailsModel> products;
  final double total;
  final String orderId;
  final String address;
  final String time;
  String orderStatus;

  OrderDetailModel({
    required this.products,
    required this.total,
    required this.orderId,
    required this.address,
    required this.time,
    required this.orderStatus
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json){
    return OrderDetailModel(
      products: List<ProductDetailsModel>.from(
        json['products'].map(
          (product) => ProductDetailsModel.fromJson(product),
        ),
      ),
      total: json['total'], 
      orderId: json['orderId'], 
      address: json['address'], 
      time: json['time'], 
      orderStatus: json['orderStatus']
    );
  }
}