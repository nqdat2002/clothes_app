import 'package:clothes_app/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen(
      {super.key, required this.orderAmount, required this.orderId});

  final String orderId;
  final double orderAmount;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;

  final List<Map<String, String>> paymentMethods = [
    {
      "name": "ZaloPay",
      "logo": "https://s3.thoainguyentek.com/2021/11/zalopay-logo.png"
    }, // Path to ZaloPay logo
    {
      "name": "VNPay",
      "logo":
          "https://vinadesign.vn/uploads/images/2023/05/vnpay-logo-vinadesign-25-12-57-55.jpg"
    }, // Path to VNPay logo
    {
      "name": "MoMo",
      "logo": "https://upload.wikimedia.org/wikipedia/vi/f/fe/MoMo_Logo.png"
    }, // Path to MoMo logo
  ];

  OrderService orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lựa chọn thanh toán"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Điều hướng về màn hình entry_point khi bấm mũi tên quay lại
            Navigator.of(context).pushReplacementNamed('entry_point');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID
            Text(
              "Mã đơn hàng:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.orderId,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 24.0),

            // Payment Method
            Text(
              "Phương thức thanh toán:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Column(
              children: paymentMethods.map((method) {
                return RadioListTile<String>(
                  value: method["name"]!,
                  groupValue: selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                  title: Row(
                    children: [
                      Image.network(
                        method["logo"]!,
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 10),
                      Text(method["name"]!),
                    ],
                  ),
                );
              }).toList(),
            ),
            const Divider(height: 24.0),

            // Order Amount
            Text(
              "Số tiền đơn hàng:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              "${widget.orderAmount.toStringAsFixed(0)} VNĐ",
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),

            const Spacer(),

            // Confirm Button
            ElevatedButton(
              onPressed: () async {
                if (selectedPaymentMethod == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Vui lòng chọn phương thức thanh toán")),
                  );
                } else {
                  String paymentLink = await orderService.createLinkPayment(
                      widget.orderId, widget.orderAmount);
                  _showOrderSuccessDialog(paymentLink);

                  bool paymentSuccess =
                      await checkPaymentStatus(widget.orderId);
                  if (paymentSuccess) {
                    Navigator.pushReplacementNamed(context, 'entry_point');
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Xác nhận Thanh toán"),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderSuccessDialog(String paymentLink)  {
    final Uri paymentUri = Uri.parse(paymentLink);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Thanh toán thành công"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Mở link thanh toán để hoàn tất:"),
              TextButton(
                
                onPressed: () async {
                  if (await canLaunchUrl(paymentUri)) {
                    await launchUrl(paymentUri);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Không thể mở liên kết: $paymentLink')),
                    );
                  }
                },

                child: const Text("Mở link thanh toán"),
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('entry_point');
                },
                child: const Text("Về trang chủ"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> checkPaymentStatus(String orderId) async {
    try {
      bool ok = await orderService.checkStatusPayment(orderId).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          return false;
        },
      );
      return ok;
    } catch (e) {
      return false;
    }
  }
}
