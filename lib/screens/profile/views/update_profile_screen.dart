import 'package:clothes_app/helpers/constants.dart';
import 'package:clothes_app/models/user_profile.dart';
import 'package:clothes_app/routes/route_constants.dart';
import 'package:clothes_app/services/user/user_service.dart';
import 'package:flutter/material.dart';

class UpdateProfileScreen extends StatefulWidget {
  final UserProfile user;
  const UpdateProfileScreen({super.key, required this.user});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _photoUrlController = TextEditingController();

  late UserProfile us;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    us = widget.user;
    setState(() {
      _displayNameController.text = us.displayName;
      _emailController.text = us.email;
      _phoneController.text = us.phoneNumber;
      _photoUrlController.text = us.photoURL;
    });
    // });
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _photoUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cập nhật thông tin"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  _photoUrlController.text,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png?20200919003010",
                      width: 60.0,
                      height: 60.0,
                    );
                  },
                  width: 60.0,
                  height: 60.0,
                ),
              ),

              const SizedBox(height: 16),

              // Display Name
              TextFormField(
                controller: _displayNameController,
                decoration: const InputDecoration(
                  labelText: "Tên hiển thị",
                  labelStyle: TextStyle(color: primaryColor),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tên hiển thị không được để trống.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                readOnly: true,
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Địa chỉ Email",
                  labelStyle: TextStyle(color: primaryColor),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Địa chỉ Email không được để trống.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Phone Number
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: "Số điện thoại",
                  labelStyle: TextStyle(color: primaryColor),
                  ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Số điện thoại không được để trống.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email Verified
              Row(
                
                children: [
                  const SizedBox(width: 10),

                  const Text("Xác thực Email: ", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),),
                  // const Spacer(),
                  const SizedBox(width: 16),
                  Text(
                    us.emailVerified ? "Đã Xác Thực" : "Chưa Xác Thực",
                    style: TextStyle(
                      fontSize: 16,
                      color: us.emailVerified ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Submit Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final updatedProfile = UserProfile(
                      displayName: _displayNameController.text,
                      email: _emailController.text,
                      phoneNumber: _phoneController.text,
                      photoURL: _photoUrlController.text,
                      emailVerified: us.emailVerified,
                    );

                    UserServices userServices = UserServices();
                    bool ok =
                        await userServices.updateUserProfile(updatedProfile);
                    if (ok) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Cập nhật thông tin thành công!"),
                        ),
                      );
                    }
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, entryPointScreenRoute);
                    // Navigator.pop(context, updatedProfile);
                  }
                },
                child: const Text("Cập nhật"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
