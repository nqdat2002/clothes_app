import 'package:clothes_app/repository/auth/auth_repository.dart';

abstract class AuthenticationEvent{
  const AuthenticationEvent();
}

class AuthenticationStatusChanged extends AuthenticationEvent{
  const AuthenticationStatusChanged({required this.status});

  final AuthenticationStatus status;
}

class AuthenticationLogoutRequest extends AuthenticationEvent{

}