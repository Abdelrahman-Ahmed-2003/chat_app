import 'package:chat_app/core/themes/styles.dart';
import 'package:flutter/material.dart';

class RegisterRow extends StatelessWidget {
  const RegisterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'
        ,style: TextStyle(fontWeight: FontWeight.w500),),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
          child: Text('Register here',
          style: Styles.textSytle15),
        ),
      ],
    );
  }
}