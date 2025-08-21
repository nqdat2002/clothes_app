import 'package:clothes_app/helpers/constants.dart';
import 'package:flutter/material.dart';
// import 'package:e_shop/constants.dart';
// import 'package:e_shop/route/route_constants.dart';

import 'widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/login.png",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Chào mừng bạn đã trở lại!",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "Đăng nhập bằng dữ liệu bạn đã nhập khi đăng ký.",
                  ),
                  const SizedBox(height: defaultPadding),
                  const LogInForm(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
