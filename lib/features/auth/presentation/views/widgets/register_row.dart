import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/auth/presentation/views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterRow extends StatelessWidget {
  const RegisterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Don\'t have an account?'
        ,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15.sp),),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignupView()));
          },
          child: Text('Register here',
          style: Styles.textSytle15),
        ),
      ],
    );
  }
}