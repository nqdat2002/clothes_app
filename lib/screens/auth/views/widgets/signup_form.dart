import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/routes/route_constants.dart';
import 'package:clothes_app/screens/auth/bloc/form/form_submission_status.dart';
import 'package:clothes_app/screens/auth/bloc/signup/signup_bloc.dart';
import 'package:clothes_app/screens/auth/bloc/signup/signup_event.dart';
import 'package:clothes_app/screens/auth/bloc/signup/signup_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() {
    return _SignUpFormState();
  }
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController =
      TextEditingController(text: "datfeed.2706@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "datnq123");
  bool _isChecked = false;

  @override
  void initState() {
    _isChecked = false;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
            return TextFormField(
              controller: emailController,
              onChanged: (data) {
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {}
                setState(() {});
                context.read<SignupBloc>().add(SignupEmailChanged(email: data));
              },
              onSaved: (emal) {
                // Email
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
                          // .withOpacity(0.3),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: defaultPadding),
          BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
            return TextFormField(
              controller: passwordController,
              onSaved: (pass) {
                // Password
              },
              onChanged: (data) {
                setState(() {});
                context
                    .read<SignupBloc>()
                    .add(SignupPasswordChanged(password: data));
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
                            // .withOpacity(0.3),
                        BlendMode.srcIn),
                  ),
                ),
              ),
            );
          }),

          Row(
            children: [
              Checkbox(
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
              ),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: "Tôi đồng ý với ",
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                                context, termsOfServicesScreenRoute);
                          },
                        text: "Chính sách bảo mật.",
                        style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: defaultPadding * 2),

          // BlocBuilder<SignupBloc, SignupState>(
          //   builder: (context, state) {
          //     final isSubmitting = state.formStatus is FormSubmitting;
          //     return ElevatedButton(
          //       onPressed: isSubmitting && _isChecked
          //           ? null
          //           : () {
          //               context.read<SignupBloc>().add(SignupSubmitted(
          //                     email: emailController.text,
          //                     password: passwordController.text,
          //                   ));
          //             },
          //       child: isSubmitting
          //           ? const CircularProgressIndicator(color: Colors.white)
          //           : const Text("Sign Up"),
          //     );
          //   },
          // ),
          BlocBuilder<SignupBloc, SignupState>(
            builder: (context, state) {
              final isSubmitting = state.formStatus is FormSubmitting;
              return ElevatedButton(
                onPressed: (!isSubmitting &&
                        _isChecked) 
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SignupBloc>().add(SignupSubmitted(
                                email: emailController.text,
                                password: passwordController.text,
                              ));
                        }
                      }
                    : null, 
                child: isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Đăng ký"),
              );
            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Bạn đã có tài khoản?"),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, logInScreenRoute);
                },
                child: const Text("Đăng nhập"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
