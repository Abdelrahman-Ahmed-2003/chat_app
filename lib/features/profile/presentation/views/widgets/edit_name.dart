import 'package:chat_app/core/sharedWidgets/custom_text.dart';
import 'package:flutter/material.dart';

class EditName extends StatelessWidget {
  final TextEditingController usernameController;
  const EditName({super.key, required this.usernameController});

  @override
  Widget build(BuildContext context) {
    return customText(
      type: TextInputType.name,
      label: 'Name',
      hint: 'Your name',
      prefix: Icons.person,
      controller: usernameController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
    );
  }
}
