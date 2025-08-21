import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationMethod {
  static void showToast(String message, {ToastGravity gravity = ToastGravity.BOTTOM, int duration = 2, Color backgroundColor = Colors.green, Color textColor = Colors.white}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: duration, 
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }

  static void showSnackBar(BuildContext context, String message, {int duration = 3, Color backgroundColor = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: duration), 
        backgroundColor: backgroundColor,
      ),
    );
  }
}
