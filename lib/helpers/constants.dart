import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'token_manager.dart';

const productDemoImg1 = "https://res.cloudinary.com/dsg8jgnhy/image/upload/v1731253391/Clothes/umgyubeljafulobptiim.png";
const productDemoImg2 = "https://res.cloudinary.com/dsg8jgnhy/image/upload/v1731253390/Clothes/z6es4chuob2zubwwqvri.png";
const productDemoImg3 = "https://res.cloudinary.com/dsg8jgnhy/image/upload/v1731253389/Clothes/z3lvzhewcfom6amzbrg9.png";
const productDemoImg4 = "https://res.cloudinary.com/dsg8jgnhy/image/upload/v1731253388/Clothes/kkdzmqfnagr9qswtd6gb.png";
const productDemoImg5 = "https://res.cloudinary.com/dsg8jgnhy/image/upload/v1731253388/Clothes/ceaxzxzj2niwdkmghw1e.png";
const productDemoImg6 = "https://res.cloudinary.com/dsg8jgnhy/image/upload/v1731253388/Clothes/el6ydtey9sf0vkdzuuxk.png";

const grandisExtendedFont = "Grandis Extended";
const Color primaryColor = Color(0xFFDB4040);

const MaterialColor primaryMaterialColor = MaterialColor(
  0xFFDB4040,
  <int, Color>{
    50: Color(0xFFFFEDED), 
    100: Color(0xFFFFD2D2),
    200: Color(0xFFFFA8A8),
    300: Color(0xFFFF7E7E),
    400: Color(0xFFFF5D5D), 
    500: Color(0xFFDB4040), 
    600: Color(0xFFC13A3A), 
    700: Color(0xFFA83333),
    800: Color(0xFF8F2C2C), 
    900: Color(0xFF6E2121), 
  },
);

const Color blackColor = Color(0xFF16161E);
const Color blackColor80 = Color(0xFF45454B);
const Color blackColor60 = Color(0xFF737378);
const Color blackColor40 = Color(0xFFA2A2A5);
const Color blackColor20 = Color(0xFFD0D0D2);
const Color blackColor10 = Color(0xFFE8E8E9);
const Color blackColor5 = Color(0xFFF3F3F4);

const Color whiteColor = Colors.white;
const Color whileColor80 = Color(0xFFCCCCCC);
const Color whileColor60 = Color(0xFF999999);
const Color whileColor40 = Color(0xFF666666);
const Color whileColor20 = Color(0xFF333333);
const Color whileColor10 = Color(0xFF191919);
const Color whileColor5 = Color(0xFF0D0D0D);

const Color greyColor = Color(0xFFB8B5C3);
const Color lightGreyColor = Color(0xFFF8F8F9);
const Color darkGreyColor = Color(0xFF1C1C25);
const Color purpleColor = Color(0xFF7B61FF);
const Color successColor = Color(0xFF2ED573);
const Color warningColor = Color(0xFFFFBE21);
const Color errorColor = Color(0xFFEA5B5B);

const double defaultPadding = 16.0;
const double defaultBorderRadious = 12.0;
const Duration defaultDuration = Duration(milliseconds: 300);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Mật khẩu là bắt buộc'),
  MinLengthValidator(8, errorText: 'Mật khẩu phải chứa ít nhất 8 ký tự'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'Mật khẩu phải chứa ít nhất một ký tự đặc biệt'),
]);

final emaildValidator = MultiValidator([
  RequiredValidator(errorText: 'Email là bắt buộc'),
  EmailValidator(errorText: "Nhập đúng định dạng email"),
]);

final searchForm = MultiValidator([
  RequiredValidator(errorText: 'Vui lòng nhập từ khóa'),
  MinLengthValidator(2, errorText: 'Từ khóa phải có ít nhất 2 ký tự'),
  MaxLengthValidator(50, errorText: 'Từ khóa không được vượt quá 50 ký tự'),
]);

const pasNotMatchErrorText = "Mật khẩu không khớp";

const baseAPI = "https://e040-14-191-33-101.ngrok-free.app/api/v1";

Map<String, String> defaultHeaders = {
  'Content-Type': 'application/json; charset=utf-8',
  'accept': 'application/json',
  'ngrok-skip-browser-warning': 'true',
  'Authorization': 'Bearer ${TokenManager.instance.accessToken}',

};

const Map<String, Color> colorMap = {
  "Beige": Color(0xFFE6E6A5),
  "Black"  : Color(0xFF000000),
  "Blue": Color(0xFF9FE1DD),
  "Brown" : Color(0xFF795548),
  "Gray": Color(0xFF9E9E9E),
  "Green": Color(0xFFB1CC63),
  "Red": Color(0xFFEA6262),
  "White": Color(0xFFFFFFFF),
};

const List<String> defaultaddresses = [
  '123 Đường ABC, Quận 1, TP.HCM',
  '456 Đường DEF, Quận 3, TP.HCM',
  '789 Đường GHI, Quận 5, TP.HCM',
  '101 Đường JKL, Quận Ba Đình, Hà Nội',
  '202 Đường MNO, Quận Hoàn Kiếm, Hà Nội',
  '303 Đường PQR, Quận Hai Bà Trưng, Hà Nội',
];
class OrderStatus {
  static const String pendingPayment = "Đang chờ thanh toán";
  static const String successfulPayment = "Thanh toán thành công";
  static const String paymentFailed = "Thanh toán thất bại";
  static const String processing = "Đang xử lý";
  static const String shipping = "Đang giao hàng";
  static const String completed = "Hoàn thành";
  static const String cancelled = "Đã hủy";
  static const String refunded = "Đã hoàn tiền";
}