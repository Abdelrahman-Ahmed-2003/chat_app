import 'package:chat_app/features/auth/presentation/views/widgets/email_field.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/login_button.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/login_title.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/logo_widget.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/password_field.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/register_row.dart';
import 'package:chat_app/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoWidget(),
              const LoginTitle(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.13),
              EmailField(emailController: emailController),
              SizedBox(height:MediaQuery.of(context).size.height * 0.018),
              PasswordField(
                  passwordController: passwordController,
                  toogleVisibility: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  isPasswordVisible: isPasswordVisible),
              SizedBox(height: MediaQuery.of(context).size.height * 0.13),
              LoginButton(
                  onScuccess: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeView()));
                  },
                  emailController: emailController,
                  passwordController: passwordController),
              SizedBox(height:MediaQuery.of(context).size.height * 0.018),
              const RegisterRow(),
            ],
          ),
        ),
      ),
    );
  }
}
