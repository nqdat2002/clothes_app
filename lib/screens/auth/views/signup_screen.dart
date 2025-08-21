import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/screens/auth/bloc/form/form_submission_status.dart';
import 'package:clothes_app/screens/auth/bloc/signup/signup_bloc.dart';
import 'package:clothes_app/screens/auth/bloc/signup/signup_state.dart';
import 'package:clothes_app/screens/auth/views/verify_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state.formStatus is SubmissionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Đăng ký thành công. Vui lòng xác minh Email của bạn, sau đó đăng nhập.")),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const VerifyEmailScreen()),
            );
          } else if (state.formStatus is SubmissionFailed) {
            final error = (state.formStatus as SubmissionFailed).exception;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Đăng ký không thành công: $error")),
            );
          }
        },
        child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/signup.png",
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Chúng ta hãy bắt đầu nhé!",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "Vui lòng nhập dữ liệu hợp lệ của bạn để tạo tài khoản.",
                  ),
                  const SizedBox(height: defaultPadding),
                  const SignUpForm(),
                  const SizedBox(height: defaultPadding),
                ],
              ),
            )
          ],
        ),
      )
    ),
  );
  }
}
