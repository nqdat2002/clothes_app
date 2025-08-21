import 'package:clothes_app/models/product_detail_model.dart';
import 'package:clothes_app/models/product_model.dart';

final sampleProduct = ProductDetailsModel(
  product: ProductModel(
    productId: 'sampleProductId',
    image: 'https://res.cloudinary.com/dsg8jgnhy/image/upload/v1731253391/Clothes/umgyubeljafulobptiim.png',
    name: 'Áo Polo',
    description: 'Sản phẩm áo thun nam chất lượng cao',
    price: 100000,
    status: true,
  ),
  sizeId: 'M',
  colorId: 'Red',
  quantity: 3,
  isSelected: true,
);