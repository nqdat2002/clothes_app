import 'package:clothes_app/helpers/constants.dart';
import 'package:flutter/material.dart';

CheckboxThemeData checkboxThemeData = CheckboxThemeData(
  // ignore: deprecated_member_use
  checkColor: MaterialStateProperty.all(Colors.white),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(defaultBorderRadious / 2),
    ),
  ),
  side: const BorderSide(color: whileColor40),
);
