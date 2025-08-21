import 'package:clothes_app/screens/cart/bloc/cart_event.dart';
import 'package:clothes_app/screens/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothes_app/models/product_detail_model.dart';
import 'package:clothes_app/services/cart_service.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService cartService;

  CartBloc({required this.cartService}) : super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<IncrementQuantity>(_onIncrementQuantity);
    on<DecrementQuantity>(_onDecrementQuantity);
    on<ToggleSelection>(_onToggleSelection);
    on<RemoveFromCart>(_onRemoveFromCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    try {
      final cartProducts = await cartService.getCart();
      if (emit.isDone) return;
      emit(CartLoaded(cartProducts));
    } catch (e) {
      if (emit.isDone) return;
      emit(const CartError('Lỗi tải giỏ hàng'));
    }
  }

  Future<void> _onIncrementQuantity(
      IncrementQuantity event, Emitter<CartState> emit) async {
    // if (state is CartLoaded) {
    //   final cartProducts =
    //       List<ProductDetailsModel>.from((state as CartLoaded).cartProducts);
    //   cartProducts[event.index].quantity++;
    //   if (emit.isDone) return;
    //   emit(CartLoaded(cartProducts)); // Emit new state immediately

    //   final success = await cartService.changeQuantity(
    //     cartProducts[event.index].product.id,
    //     cartProducts[event.index].sizeId,
    //     cartProducts[event.index].colorId,
    //     1,
    //   );

    //   if (!success) {
    //     // Revert the quantity change if the API call fails
    //     cartProducts[event.index].quantity--;
    //     if (emit.isDone) return;
    //     emit(CartLoaded(cartProducts));
    //     emit(const CartError('Failed to update product quantity'));
    //   }
    // }

    if (state is CartLoaded) {
      final cartProducts = List<ProductDetailsModel>.from((state as CartLoaded).cartProducts);
      final updatedProduct = cartProducts[event.index].copyWith(
        quantity: cartProducts[event.index].quantity + 1,
      );
      cartProducts[event.index] = updatedProduct;
      if (emit.isDone) return;
      emit(CartLoaded(cartProducts)); // Emit new state immediately

      final success = await cartService.changeQuantity(
        cartProducts[event.index].product.productId,
        cartProducts[event.index].sizeId,
        cartProducts[event.index].colorId,
        1,
      );

      if (!success) {
        // Revert the quantity change if the API call fails
        cartProducts[event.index] = updatedProduct.copyWith(
          quantity: updatedProduct.quantity - 1,
        );
        if (emit.isDone) return;
        emit(CartLoaded(cartProducts));
        emit(const CartError('Lỗi cập nhật số lượng sản phẩm'));
      }
    }
  }

  Future<void> _onDecrementQuantity(
      DecrementQuantity event, Emitter<CartState> emit) async {
    // if (state is CartLoaded) {
    //   final cartProducts =
    //       List<ProductDetailsModel>.from((state as CartLoaded).cartProducts);
    //   if (cartProducts[event.index].quantity > 1) {
    //     cartProducts[event.index].quantity--;
    //     if (emit.isDone) return;
    //     emit(CartLoaded(cartProducts)); // Emit new state immediately

    //     final success = await cartService.changeQuantity(
    //       cartProducts[event.index].product.id,
    //       cartProducts[event.index].sizeId,
    //       cartProducts[event.index].colorId,
    //       -1,
    //     );

    //     if (!success) {
    //       // Revert the quantity change if the API call fails
    //       cartProducts[event.index].quantity++;
    //       if (emit.isDone) return;
    //       emit(CartLoaded(cartProducts));
    //       emit(CartError('Failed to update product quantity'));
    //     }
    //   }
    // }
    if (state is CartLoaded) {
      final cartProducts = List<ProductDetailsModel>.from((state as CartLoaded).cartProducts);
      if (cartProducts[event.index].quantity > 1) {
        final updatedProduct = cartProducts[event.index].copyWith(
          quantity: cartProducts[event.index].quantity - 1,
        );
        cartProducts[event.index] = updatedProduct;
        emit(CartLoaded(cartProducts)); // Emit new state immediately

        final success = await cartService.changeQuantity(
          cartProducts[event.index].product.productId,
          cartProducts[event.index].sizeId,
          cartProducts[event.index].colorId,
          -1,
        );

        if (!success) {
          // Revert the quantity change if the API call fails
          cartProducts[event.index] = updatedProduct.copyWith(
            quantity: updatedProduct.quantity + 1,
          );
          emit(CartLoaded(cartProducts));
          emit(const CartError('Lỗi cập nhật số lượng sản phẩm'));
        }
      }
    }
  }

  Future<void> _onToggleSelection(ToggleSelection event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final cartProducts =
          List<ProductDetailsModel>.from((state as CartLoaded).cartProducts);
      final updatedProduct = cartProducts[event.index].copyWith(
        isSelected: !cartProducts[event.index].isSelected,
      );
      cartProducts[event.index] = updatedProduct;
      emit(CartLoaded(cartProducts));
    }
  }

  Future<void> _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final cartProducts =
          List<ProductDetailsModel>.from((state as CartLoaded).cartProducts);
      final removedProduct = cartProducts.removeAt(event.index);
      if (emit.isDone) return;
      emit(CartLoaded(cartProducts));

      final success = await cartService.removeProduct(
        removedProduct.product.productId,
        removedProduct.sizeId,
        removedProduct.colorId,
      );

      if (!success) {
        cartProducts.insert(event.index, removedProduct);
        if (emit.isDone) return;
        emit(CartLoaded(cartProducts));
        emit(const CartError('Lỗi xóa sản phẩm khỏi giỏ hàng'));
      }
    }
  }
}
