import 'package:clothes_app/models/product_detail_model.dart';
import 'package:clothes_app/screens/payment/payment_screen.dart';
import 'package:clothes_app/services/order_service.dart';
import 'package:clothes_app/services/user/address_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key, required this.selectedProduct});
  final List<ProductDetailsModel> selectedProduct;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  AddressService addressService = AddressService();
  List<String> addresses = [];
  OrderService orderService = OrderService();
  late List<ProductDetailsModel> selectedproductS = [];

  late String _selectedAddress = "";
  // double _calculateTotal(ProductDetailsModel product) {
  //   return product.product.price * product.quantity;
  // }
  double _calculateTotal() {
    return selectedproductS.fold(0.0, (total, product) {
      return total + product.product.price * product.quantity;
    });
  }

  void _showOrderSuccessDialog(
      BuildContext context, double totalOrder, String orderId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Đặt hàng thành công'),
          content: const Text('Bạn muốn thanh toán ngay hay thanh toán sau?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('entry_point');
              },
              child: const Text('Thanh toán sau'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                      orderId: orderId,
                      orderAmount: totalOrder,
                    ),
                  ),
                );
              },
              child: const Text('Thanh toán ngay'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    selectedproductS = widget.selectedProduct;
    _fetchAddress();
  }

  Future<void> _fetchAddress() async {
    try {
      List<String> listaddressz = await addressService.getUserAddress();
      if (mounted) {
        setState(() {
          addresses = listaddressz;
          if (addresses.isNotEmpty) {
            _selectedAddress = addresses[0]; // Default to the first address
          }
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching address of user");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = _calculateTotal();
    const shippingFee = 30000;
    final totalOrder = total + shippingFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đặt Hàng'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: selectedproductS.length,
                itemBuilder: (context, index) {
                  final product = selectedproductS[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            product.product.image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            product.product.name,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            product.product.description,
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '${product.product.price} VNĐ',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Size: ${product.sizeId}, Color: ${product.colorId}',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'x${product.quantity}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Địa chỉ giao hàng',
                border: OutlineInputBorder(),
              ),
              value: _selectedAddress,
              items: addresses.map((String address) {
                return DropdownMenuItem<String>(
                  value: address,
                  child: Text(address),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedAddress = newValue!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tổng đơn hàng: ${total.toStringAsFixed(0)} VNĐ',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Phí vận chuyển: ${shippingFee.toStringAsFixed(0)} VNĐ',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Tổng cộng: ${totalOrder.toStringAsFixed(0)} VNĐ',
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: () async {
            //     if (selectedproductS.isEmpty) {
            //       // Ensure all required fields are filled
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(
            //             content: Text('Vui lòng chọn địa chỉ và sản phẩm')),
            //       );
            //       return;
            //     }

            //     setState(() {});

            //     try {
            //       final success = await Future.delayed(
            //         const Duration(seconds: 2),
            //         () => orderService.createOrder(
            //             selectedproductS, _selectedAddress),
            //       );

            //       if (success != "") {
            //         _showOrderSuccessDialog(context, totalOrder, success);
            //       } else {
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           const SnackBar(
            //               content:
            //                   Text('Đặt hàng thất bại. Vui lòng thử lại.')),
            //         );
            //       }
            //     } catch (e) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text('Lỗi: $e')),
            //       );
            //     } finally {
            //       setState(() {});
            //     }
            //   },
            //   child: const Text('Đặt hàng ngay'),
            // ),

           ElevatedButton(
            onPressed: () {
              final currentContext = context; // Lưu lại context trước khi vào async

              if (selectedproductS.isEmpty || _selectedAddress == "") {
                ScaffoldMessenger.of(currentContext).showSnackBar(
                  const SnackBar(
                    content: Text('Vui lòng chọn địa chỉ và sản phẩm'),
                  ),
                );
                return;
              }

              setState(() {
                // Có thể thêm trạng thái loading nếu cần
              });

              _handleOrder(currentContext, totalOrder);
            },
            child: const Text('Đặt hàng ngay'),
          ),

          ],
        ),
      ),
    );
  }

  Future<void> _handleOrder(BuildContext currentContext, totalOrder) async {
    try {
      final success = await orderService.createOrder(
        selectedproductS,
        _selectedAddress,
      );

      if (!mounted) return;

      if (success != "") {
        _showOrderSuccessDialog(currentContext, totalOrder, success);
      } else {
        ScaffoldMessenger.of(currentContext).showSnackBar(
          const SnackBar(
            content: Text('Đặt hàng thất bại. Vui lòng thử lại.'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(currentContext).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
    } finally {
      if (!mounted) return;
      setState(() {
        // Kết thúc trạng thái loading nếu có
      });
    }
  }

}
