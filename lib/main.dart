import 'package:clothes_app/app.dart';
import 'package:clothes_app/repository/auth/auth_repository.dart';
import 'package:clothes_app/repository/user/user_repository.dart';
import 'package:clothes_app/screens/auth/bloc/authenticate/auth_bloc.dart';
import 'package:clothes_app/screens/auth/bloc/login/login_bloc.dart';
import 'package:clothes_app/screens/auth/bloc/signup/signup_bloc.dart';
import 'package:clothes_app/screens/cart/bloc/cart_bloc.dart';
import 'package:clothes_app/services/cart_service.dart';
import 'package:clothes_app/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'The Shop',
//       theme: AppTheme.lightTheme(context),
//       themeMode: ThemeMode.light,
//       onGenerateRoute: router.generateRoute,
//       initialRoute: onbordingScreenRoute,
//       // home: const LoginScreen(),
//     );
//   }
// }

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthenticationBloc(
                  authenticationRepository: _authenticationRepository,
                  userRepository: _userRepository,
                ),
          ),
          BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
          BlocProvider<LoginBloc>(
            create: (context) =>
                LoginBloc(authRepository: _authenticationRepository),
          ),
          BlocProvider(create: (context) => SignupBloc(authRepository: _authenticationRepository),),
          BlocProvider(create: (context) => CartBloc(cartService: CartService()),),
        ],
        child: const AppView(),
      ),
    );
  }
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     