import 'package:chat_app/core/sharedWidgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  
  final VoidCallback onScuccess;
  const SignupButton({
    super.key,
    required this.onScuccess,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
    required this.usernameController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        text: 'Signup',
        func: () {
          if (usernameController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Please enter your name',style: TextStyle(fontSize: 20.sp),),
              //backgroundColor: Colors.red,
            ));
          } else if (emailController.text.isEmpty ||
              !RegExp(r'^[^\s@]+@gmail\.com$').hasMatch(emailController.text)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Please enter a valid Gmail address',style: TextStyle(fontSize: 20.sp)),
              //backgroundColor: Colors.red,
            ));
          } else if (phoneController.text.isEmpty ||
              phoneController.text.length != 11 ||
              RegExp(r'\D').hasMatch(phoneController.text)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Please enter vaild phone number containing only digits',style: TextStyle(fontSize: 20.sp)),
              //backgroundColor: Colors.red,
            ));
          } else if (passwordController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Please enter your password',style: TextStyle(fontSize: 20.sp)),
              //backgroundColor: Colors.red,
            ));
          } else {
            onScuccess();
          }
        });
  }
}
