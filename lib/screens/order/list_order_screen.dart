import 'package:clothes_app/models/order_detail_model.dart';
import 'package:clothes_app/screens/order/order_details_screen.dart';
import 'package:clothes_app/services/order_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ListOrderScreen extends StatefulWidget {
  const ListOrderScreen({super.key});

  @override
  State<ListOrderScreen> createState() => _ListOrderScreenState();
}

class _ListOrderScreenState extends State<ListOrderScreen> {
  OrderService orderService = OrderService();
  List<OrderDetailModel> listOrders = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchListOrders();
  }

  Future<void> _fetchListOrders() async {
    try {
      List<OrderDetailModel> fetchedOrders = await orderService.getOrders();
      setState(() {
        listOrders = fetchedOrders;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching list orders");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách đơn hàng"),
      ),
      body: listOrders.isEmpty
          ? const Center(
              child: Text(
                "Bạn không có đơn hàng nào",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: listOrders.length,
              itemBuilder: (context, index) {
                final order = listOrders[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text("Mã đơn hàng: ${order.orderId}"),
                    subtitle: Text("Ngày đặt: ${order.time}"),
                    trailing: Text(order.orderStatus,
                        style: const TextStyle(color: Colors.red)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OrderDetailScreen(order: order)),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
