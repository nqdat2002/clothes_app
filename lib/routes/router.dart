import 'package:clothes_app/entry_point.dart';
import 'package:clothes_app/routes/route_constants.dart';
import 'package:clothes_app/screens/address/views/address_screen.dart';
import 'package:clothes_app/screens/auth/views/login_screen.dart';
import 'package:clothes_app/screens/auth/views/signup_screen.dart';
import 'package:clothes_app/screens/cart/views/cart_screen.dart';
import 'package:clothes_app/screens/home/views/home_screen.dart';
import 'package:clothes_app/screens/onbording/views/onbording_screen.dart';
import 'package:clothes_app/screens/order/list_order_screen.dart';
import 'package:clothes_app/screens/policy/privacy_policy_screen.dart';
import 'package:clothes_app/screens/product/views/product_details_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case onbordingScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const OnBordingScreen(),
      );

    case logInScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );

    case signUpScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      );

    case termsOfServicesScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const PrivacyPolicyScreen(),
      );

    case homeScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

    case productDetailsScreenRoute:
      return MaterialPageRoute(
        builder: (context) {
          final arguments = settings.arguments as Map<String, dynamic>? ?? {};
          bool isProductAvailable = arguments['status'] as bool? ?? true;
          String productId = arguments['productId'] ?? '';

          return ProductDetailsScreen(
            isProductAvailable: isProductAvailable,
            productId: productId,
          );
        },
      );

    case cartScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const CartScreen(),
      );

    case listOrdersScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const ListOrderScreen(),
      );

    case addressesScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const AddressScreen()
      );

    case entryPointScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const EntryPoint(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const EntryPoint(),
      );
  }
}
