import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/auth/presentation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginRow extends StatelessWidget {
  const LoginRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account?'
        ,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15.sp),),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginView()));
          },
          child: Text('Login here',
          style: Styles.textSytle15),
        ),
      ],
    );
  }
}