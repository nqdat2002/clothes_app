import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/models/product_detail_model.dart';
import 'package:clothes_app/screens/order/order_screens.dart';
import 'package:clothes_app/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothes_app/screens/cart/bloc/cart_bloc.dart';
import 'package:clothes_app/screens/cart/bloc/cart_event.dart';
import 'package:clothes_app/screens/cart/bloc/cart_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _calculateTotal(List<ProductDetailsModel> cartProducts) {
    return cartProducts
        .where((product) => product.isSelected)
        .fold(0.0, (total, product) => total + product.product.price * product.quantity);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(cartService: CartService())..add(LoadCart()),
      child: Scaffold(
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              final total = _calculateTotal(state.cartProducts);
              final hasSelectedProducts = state.cartProducts.any((product) => product.isSelected);
              final selectedProducts = state.cartProducts.where((product) => product.isSelected).toList();

              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        itemCount: state.cartProducts.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(state.cartProducts[index].product.productId.toString()), // Unique key
                            direction: DismissDirection.endToStart, // Vuốt từ phải sang trái
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (direction) {
                              // Xử lý xóa sản phẩm khỏi giỏ hàng
                              context.read<CartBloc>().add(RemoveFromCart(index));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${state.cartProducts[index].product.name} đã bị xóa khỏi giỏ hàng.'),
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      activeColor: primaryColor,
                                      value: state.cartProducts[index].isSelected,
                                      // value: index.isEven,
                                      onChanged: (value) {
                                        context.read<CartBloc>().add(ToggleSelection(index));
                                      },
                                    ),
                                    Image.network(
                                      state.cartProducts[index].product.image,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.cartProducts[index].product.name,
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            state.cartProducts[index].product.description,
                                            style: const TextStyle(fontSize: 14.0),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            '${state.cartProducts[index].product.price} VNĐ',
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.red,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            'Size: ${state.cartProducts[index].sizeId}, Color: ${state.cartProducts[index].colorId}',
                                            style: const TextStyle(fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () {
                                            context.read<CartBloc>().add(DecrementQuantity(index));
                                          },
                                        ),
                                        Text(
                                          '${state.cartProducts[index].quantity}',
                                          style: const TextStyle(fontSize: 16.0),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            context.read<CartBloc>().add(IncrementQuantity(index));
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Tổng Cộng: $total VNĐ',
                          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: hasSelectedProducts ? () {
                            // Handle purchase action
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderScreen(
                                  selectedProduct: selectedProducts,
                                ),
                              ),
                            ); // 
                          } : null,
                          child: const Text('Mua ngay'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is CartError) {
              return Center(child: Text(state.message ?? 'Đã có lỗi xảy ra khi hiển thị giỏ hàng'));
            } else {
              return const Center(child: Text('Đã có lỗi xảy ra'));
            }
          },
        ),
      ),
    );
  }
}