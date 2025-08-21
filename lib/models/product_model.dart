import 'package:clothes_app/helpers/constants.dart';

class ProductModel {
  final String productId;
  final String image, name, description;
  final double price;
  // final double? priceAfetDiscount;
  int? discountpercent;
  final bool status;

  ProductModel({
    required this.productId,
    required this.name,
    required this.image,
    required this.description,
    required this.status,
    required this.price,
    // this.priceAfetDiscount,
    this.discountpercent,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'] as String? ?? '',
      image: json['image'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as double?)?.toDouble() ?? 0.0,
      discountpercent: json['discountpercent'] ?? 0,
      status: json['status'] as bool? ?? false,
    );
  }

  static List<ProductModel> parseList(dynamic jsonList) {
    if (jsonList == null || jsonList is! List || jsonList.isEmpty) {
      return [];
    }
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'image': image,
      'name': name,
      'description': description,
      'price': price,
      'discountpercent': discountpercent,
      'status': status,
    };
  }
}

List<ProductModel> demoPopularProducts = [
  ProductModel(
    productId: "Shirt008",
    image: productDemoImg1,
    description: "hsdjfóppgjmrhpơgdmfpgơbjmdfpgdkjpjmrspgjmrpog",
    name: "Áo Phông Hê",
    price: 240000,
    // priceAfetDiscount: 420,
    discountpercent: 20,
    status: true,
  ),
  ProductModel(
    productId: "Shirt008",
    image: productDemoImg4,
    description: "sdnfm ;sodfmnepgmnpơẹmgsak[f ègẹwmngfo[ềpmfpmgôẹmngpỏmngởq]]",
    name: "Áo Phông Hê",
    price: 240000,
    status: true,
  ),
  ProductModel(
     productId: "Shirt008",
    image: productDemoImg5,
    description: "hsffgsdfsdfjytrgvsdogvsdhoighvnshoidgnvsdiongvsodpìnmdo",
    name: "Áo Phông Hê",
    price: 240000,
    // priceAfetDiscount: 390.36,
    discountpercent: 40,
    status: true,
  ),
  ProductModel( 
    productId: "Shirt008",
    image: productDemoImg6,
    description: "áđâsdágfxzcxcá",
    name: "Áo Phông Hê",
    price: 240000,
    // priceAfetDiscount: 1200.8,
    discountpercent: 5,
    status: true,
  ),
  ProductModel(
     productId: "Shirt008",
    image: "https://res.cloudinary.com/dsg8jgnhy/image/upload/v1731253389/Clothes/z3lvzhewcfom6amzbrg9.png",
    description: "ádfáđâsdá",
    name: "Áo Phông Hê",
    price: 240000,
    // priceAfetDiscount: 390.36,
    discountpercent: 40,
    status: true,
  ),
  ProductModel(
     productId: "Shirt008",
    image: "https://res.cloudinary.com/dsg8jgnhy/image/upload/v1731253388/Clothes/zqxja0ybwrqctuba8kbn.png",
    description: "sdfgshgrfgrfgrfgrf",
    name: "Áo Phông Hê",
    price: 240000,
    // priceAfetDiscount: 1200.8,
    discountpercent: 5,
    status: true,
  ),
];
