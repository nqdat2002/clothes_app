import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/models/order_detail_model.dart';
import 'package:clothes_app/screens/payment/payment_screen.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderDetailModel order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết đơn hàng"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID: ${widget.order.orderId}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Ngày đặt: ${widget.order.time}"),
            const SizedBox(height: 10),
            Text("Trạng thái: ${widget.order.orderStatus}"),
            const SizedBox(height: 20),
            const Text(
              "Danh sách sản phẩm:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (context, index) {
                  final product = widget.order.products[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hình ảnh sản phẩm
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(product.product.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Chi tiết sản phẩm
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.product.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text("Giá: ${product.product.price} VND"),
                                const SizedBox(height: 5),
                                Text("Số lượng: ${product.quantity}"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: widget.order.orderStatus == OrderStatus.pendingPayment
                  ? () {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //       content: Text("Thanh toán đang được xử lý...")),
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                            orderId: widget.order.orderId.toString(),
                            orderAmount: widget.order.total,
                          ),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    widget.order.orderStatus == OrderStatus.pendingPayment
                        ? Colors.blue
                        : Colors.grey,
              ),
              child: Text(widget.order.orderStatus == OrderStatus.pendingPayment
                  ? "Thanh toán ngay"
                  : "Đã thanh toán"),
            ),
          ],
        ),
      ),
    );
  }
}
