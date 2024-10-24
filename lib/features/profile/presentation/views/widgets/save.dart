import 'package:chat_app/core/sharedWidgets/custom_button.dart';
import 'package:flutter/material.dart';

class Save extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  const Save({
    super.key,
    required this.phoneController,
    required this.usernameController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        text: 'save profile',
        func: () {
          if (usernameController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Please enter your name'),
              //backgroundColor: Colors.red,
            ));
          }else if (phoneController.text.isEmpty ||
              phoneController.text.length != 11 ||
              RegExp(r'\D').hasMatch(phoneController.text)) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  'Please enter vaild phone number containing only digits'),
              //backgroundColor: Colors.red,
            ));
          }else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  'Data is saved successfully'),
              //backgroundColor: Colors.red,
            ));
          }
        });
  }
}