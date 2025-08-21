import 'package:flutter/material.dart';

class QRPaymentScreen extends StatelessWidget {
  const QRPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh Toán MoMo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Quét mã QR để thanh toán bằng MoMo',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Image.network(
              'https://homepage.momocdn.net/blogscontents/momo-upload-api-220808102122-637955508824191258.png', // Replace with your QR code image URL
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('entry_point'); // Navigate to home
              },
              child: const Text('Quay về trang chủ'),
            ),
          ],
        ),
      ),
    );
  }
}