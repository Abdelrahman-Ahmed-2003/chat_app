import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Login to your account',
        style: Styles.textSytle24,
        textAlign: TextAlign.center,);
  }
}