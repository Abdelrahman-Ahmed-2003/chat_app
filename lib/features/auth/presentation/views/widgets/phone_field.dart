import 'package:chat_app/core/sharedWidgets/custom_text.dart';
import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController phoneController;
  const PhoneField({super.key,required this.phoneController});

  @override
  Widget build(BuildContext context) {
    return customText(
      type: TextInputType.phone,
      label: 'Enter your Phone number',
      hint: 'Your phone number',
      prefix: Icons.phone,
      controller: phoneController,
      validator: (value) {
        if (phoneController.text.isEmpty ||
              phoneController.text.length != 11 ||
              RegExp(r'\D').hasMatch(phoneController.text)){
          return 'Please enter your phone number';
        }
        return null;
      },
    );
  }
}