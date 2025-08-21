import 'package:equatable/equatable.dart';
import 'package:clothes_app/models/product_detail_model.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<ProductDetailsModel> cartProducts;

  const CartLoaded(this.cartProducts);

  // CartLoaded copyWith({List<ProductDetailsModel>? cartProducts}) {
  //   return CartLoaded(cartProducts ?? this.cartProducts);
  // }

  @override
  List<Object> get props => [cartProducts];
}

class CartError extends CartState {
  const CartError(String s);

  String? get message => null;
}