import 'package:chat_app/core/sharedWidgets/custom_button.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onScuccess;
  const LoginButton(
      {super.key,
      required this.onScuccess,
      required this.emailController,
      required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        text: 'Login',
        func: () {
          String trimmedEmail = emailController.text.trim();
          if (trimmedEmail.isEmpty ||
              !RegExp(r'^[^\s@]+@gmail\.com$').hasMatch(trimmedEmail)) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Please enter a valid Gmail address'),
              //backgroundColor: Colors.red,
            ));
          }else if (passwordController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Please enter your password'),
              //backgroundColor: Colors.red,
            ));
          } else {
            onScuccess();
          }
        });
  }
}
