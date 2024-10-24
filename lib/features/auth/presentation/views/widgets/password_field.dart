import 'package:chat_app/core/sharedWidgets/custom_text.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  final VoidCallback toogleVisibility;
  final bool isPasswordVisible;
  const PasswordField({super.key,required this.passwordController,required this.toogleVisibility,required this.isPasswordVisible});

  @override
  Widget build(BuildContext context) {
    return customText(
        obscureText: !isPasswordVisible,
        type: TextInputType.visiblePassword,
        label: 'Enter your password',
        hint: 'Your password',
        prefix: Icons.lock,
        suffix: isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        suffixPressed: toogleVisibility,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
        controller: passwordController,);
  }
}
