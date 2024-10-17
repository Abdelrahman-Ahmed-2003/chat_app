import 'package:chat_app/features/auth/presentation/view/widgets/email_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/login_row.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/logo_widget.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/password_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/phone_field.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/signup_button.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/signup_title.dart';
import 'package:chat_app/features/auth/presentation/view/widgets/username_field.dart';
import 'package:chat_app/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';

class SignupBody extends StatefulWidget {
  const SignupBody({super.key});

  @override
  State<SignupBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<SignupBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
            children: [
              const LogoWidget(),
              const SignupTitle(),
              //SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              const SizedBox(height: 20),
              UsernameField(usernameController: usernameController),
              const SizedBox(height: 20),
              EmailField(emailController: emailController),
              const SizedBox(height: 20),
              PhoneField(phoneController: phoneController),
              const SizedBox(height: 20),
              PasswordField(
                  passwordController: passwordController,
                  toogleVisibility: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  isPasswordVisible: isPasswordVisible),
              const SizedBox(height: 20),
              //SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              SignupButton(
                onScuccess: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeView()));
                },
                emailController: emailController,
                passwordController: passwordController,
                phoneController: phoneController,
                usernameController: usernameController,
              ),
              const SizedBox(height: 20),
              const LoginRow(),
            ],
          ),
        ),
      ),
    );
  }
}
