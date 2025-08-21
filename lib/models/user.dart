import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String email;
  final String password;

  const User({required this.email, required this.password
  });

  static const empty = User( email: '-', password: '-');

  @override
  List<Object?> get props => [email, password];

}