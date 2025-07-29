import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class LoginRow extends StatelessWidget {
  const LoginRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account?'
        ,style: TextStyle(fontWeight: FontWeight.w500),),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Text('Login here',
          style: Styles.textSytle15),
        ),
      ],
    );
  }
}