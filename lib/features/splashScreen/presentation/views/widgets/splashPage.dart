import 'package:chat_app/core/constant/asset_images.dart';
import 'package:chat_app/core/themes/colors_app.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/auth/presentation/views/login_view.dart';
import 'package:chat_app/features/home/presentation/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      print('userrrrrrrrrrrrr: ' + FirebaseAuth.instance.currentUser.toString());
      print('user in supabase:'+ Supabase.instance.client.auth.currentUser.toString());
      (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeView()))
          : Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            AssetImages.logo,
          ),
          Text(
            'WhatsUp',
            style: Styles.textSytle24.copyWith(
              color: ColorApp.primaryColor,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(
            'The best chat App of this is century',
            style: Styles.textSytle15,
          ),
        ],
      ),
    )));
  }
}
