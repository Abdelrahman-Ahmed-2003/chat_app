import 'package:chat_app/features/auth/presentation/view/widgets/email_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/login_button.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/login_title.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/logo_widget.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/password_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/register_row.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatefulWidget {
  LoginBody({super.key});

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
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              EmailField(emailController: emailController),
              const SizedBox(height: 20),
              PasswordField(
                  passwordController: passwordController,
                  toogleVisibility: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  isPasswordVisible: isPasswordVisible),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              LoginButton(
                  onScuccess: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeView()));
                  },
                  emailController: emailController,
                  passwordController: passwordController),
              const SizedBox(height: 20),
              const RegisterRow(),
            ],
          ),
        ),
      ),
    );
  }
}
