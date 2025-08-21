import 'package:clothes_app/models/user.dart';

class UserRepository {
  User? user;

  Future<User?> getUser() async {
    if (user != null) return user;
    return Future.delayed(
      const Duration(milliseconds: 300),
          () => user = const User(email: "admin", password: "admin"),
    );
  }
}