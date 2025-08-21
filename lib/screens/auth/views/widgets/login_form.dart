import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/routes/route_constants.dart';
import 'package:clothes_app/screens/auth/bloc/login/login_bloc.dart';
import 'package:clothes_app/screens/auth/bloc/login/login_event.dart';
import 'package:clothes_app/screens/auth/bloc/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({
    super.key,
  });

  // final GlobalKey<FormState> formKey;

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController =
      TextEditingController(text: "datnq2762@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "NGquocdat@@");

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Form(
      key: formKey,
      child: Column(
        children: [
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return TextFormField(
                controller: emailController,
                onSaved: (emal) {
                  // Email
                },
                onChanged: (data) {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {}
                  setState(() {});
                  context.read<LoginBloc>().add(LoginEmailChanged(email: data));
                },
                validator: emaildValidator.call,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Địa chỉ email",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding * 0.75),
                    child: SvgPicture.asset(
                      "assets/icons/Message.svg",
                      height: 24,
                      width: 24,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withAlpha((0.3 * 255).toInt()),
                          BlendMode.srcIn),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: defaultPadding),
          BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            return TextFormField(
              controller: passwordController,
              onSaved: (pass) {
                // Password
              },
              onChanged: (data) {
                setState(() {});
                context
                    .read<LoginBloc>()
                    .add(LoginPasswordChanged(password: data));
              },
              validator: passwordValidator.call,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Mật khẩu",
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding * 0.75),
                  child: SvgPicture.asset(
                    "assets/icons/Lock.svg",
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withAlpha(((0.3 * 255).toInt())),
                        BlendMode.srcIn),
                  ),
                ),
              ),
            );
          }),
          Align(
            child: TextButton(
              child: const Text("Quên mật khẩu?"),
              onPressed: () {
                // Navigator.pushNamed(
                //     context, passwordRecoveryScreenRoute);
              },
            ),
          ),
          SizedBox(
            height: size.height > 700 ? size.height * 0.1 : defaultPadding,
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(LoginSubmitted(
                    email: emailController.text,
                    password: passwordController.text));
                // Navigator.pushNamedAndRemoveUntil(
                //     context,
                //     entryPointScreenRoute,
                //     ModalRoute.withName(logInScreenRoute));
              }
            },
            child: const Text("Đăng nhập"),
          ),
          const SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Bạn chưa có tài khoản?"),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, signUpScreenRoute);
                },
                child: const Text("Đăng ký ngay!"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
