import 'package:clothes_app/repository/auth/auth_repository.dart';
import 'package:clothes_app/routes/route_constants.dart';
import 'package:clothes_app/screens/auth/bloc/authenticate/auth_bloc.dart';
import 'package:clothes_app/screens/auth/bloc/authenticate/auth_state.dart';
import 'package:clothes_app/theme/app_theme.dart';
import 'package:clothes_app/theme/bloc/theme_bloc.dart';
import 'package:clothes_app/theme/bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clothes_app/routes/router.dart' as router;
import 'package:shared_preferences/shared_preferences.dart';


class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_completed') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData? apptheme;
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        // if (state is SelectedTheme) {
          // apptheme = (state.themeType != ThemeType.Light && state.themeType != ThemeType.Dark
          //     ? AppTheme.lightTheme(context)
          //     : AppTheme.darkTheme(context));
        apptheme = AppTheme.lightTheme(context);
        // }
        return MaterialApp(
          navigatorKey: _navigatorKey,
          theme: apptheme,
          debugShowCheckedModeBanner: false,
          initialRoute: onbordingScreenRoute,
          onGenerateRoute: router.generateRoute,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) async {
                final onboardingCompleted = await isOnboardingCompleted();

                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    // Navigator.of(context).pushNamedAndRemoveUntil(entryPointScreenRoute,  (router) => false);
                    _navigator.pushNamedAndRemoveUntil(entryPointScreenRoute, (router) => false);

                    break;
                  case AuthenticationStatus.unauthenticated:
                    // Navigator.of(context).pushNamedAndRemoveUntil(logInScreenRoute, (router) => false);
                    // _navigator.pushNamedAndRemoveUntil(logInScreenRoute, (router) => false);
                    
                    if (onboardingCompleted) {
                      _navigator.pushNamedAndRemoveUntil(
                          logInScreenRoute, (router) => false);
                    } else {
                      _navigator.pushNamedAndRemoveUntil(
                          onbordingScreenRoute, (router) => false);
                    }

                    break;
                  case AuthenticationStatus.unknown:
                    _navigator.pushNamedAndRemoveUntil(onbordingScreenRoute, (router) => false);

                    break;
                }
              },
              child: child,
            );
          },
        );
      },
    );
  }
}