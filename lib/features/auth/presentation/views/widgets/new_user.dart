import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:supabase_flutter/supabase_flutter.dart';

class NewUser {
  final String emailController;
  final String passwordController;
  final String usernameController;
  final String phoneController;
  NewUser({
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
    required this.usernameController,
  });
  late firebaseAuth.UserCredential credential;

  Future<String> addNewUser() async {
    try {
      credential = await firebaseAuth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );

      return 'ok';
    } on firebaseAuth.FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> sendVerefcation() async {
    try {
      await firebaseAuth.FirebaseAuth.instance.currentUser!
          .sendEmailVerification();
      return 'ok';
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> startVerificationCheck() async {
    firebaseAuth.User? user = firebaseAuth.FirebaseAuth.instance.currentUser;

    bool isVerified = false;

    await Future.doWhile(() async {
      print('Checking email verification...');
      await Future.delayed(const Duration(seconds: 5)); // Wait for 5 seconds
      await user!.reload(); // Reload user data from Firebase
      user = firebaseAuth.FirebaseAuth.instance.currentUser;

      if (user!.emailVerified) {
        print('Email verified!');
        isVerified = true; // Update verification status
        return false; // Stop the loop
      }
      print('Email not verified yet.');
      return true; // Continue the loop
    });

    String userId = credential.user!.uid;
    print('user id is : ' + userId);

    // // Save additional user data in Firestore
    try {
      await Supabase.instance.client.from('users').insert({
        'phone_num': phoneController,
        'name': usernameController,
        'email': emailController,
        'password': passwordController
      });
    } catch (e) {
      print(
          'errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      print(e.toString());
    }

    return isVerified; // Return the final verification status
  }

  Future<String> login() async {
    try {
      final credential = await firebaseAuth.FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController, password: passwordController);
      return 'ok';
    } on firebaseAuth.FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}
