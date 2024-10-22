import 'package:chat_app/core/sharedWidgets/custom_text.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  const EmailField({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return customText(
      type: TextInputType.emailAddress,
      label: 'Enter your email',
      hint: 'Your email',
      prefix: Icons.email,
      controller: emailController,
      validator: (value) {
        if (value!.isEmpty ||
            !RegExp(r'^[^\s@]+@gmail\.com$').hasMatch(value)) {
          return 'please enter vaild email';
        }
        return null;
      },
    );
  }
}
