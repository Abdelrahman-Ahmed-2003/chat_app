import 'dart:io';

import 'package:chat_app/features/auth/presentation/views/widgets/upload_photo.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewUser {
  final String emailController;
  final String passwordController;
  final String usernameController;
  String phoneController;
  File? imageFile;
  NewUser({
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
    required this.usernameController,
    required this.imageFile,
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
    phoneController = phoneController.trim().replaceAll(' ', '');
    print(phoneController);
    print(
        'loooooooooooooooooooooooooooooooooooooooooooooooooooook upppppppppppppppppp');
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

    // // Sign up with Supabase
    // final response = await Supabase.instance.client.auth.signUp(
    //   email: emailController,
    //   password: passwordController, // Use the same password as Firebase
    // );

    // Upload the selected media
    String? publicUrl;
    var response = await Supabase.instance.client.from('users').insert({
      'phone_num': phoneController,
      'name': usernameController,
      'email': emailController,
      'password': passwordController,
      'image': publicUrl,
    }).select();
    //add to storage by id not phone number becauase if phone changed not need to update storage
    if (imageFile != null) {
      print('iddddddddddddddddddddddddddddddddddddddddddddddddddddd');
      print(response[0]['id']);
      publicUrl =
          await uploadMediaToSupabase(imageFile!, response[0]['id']);
      await updateUserProfile(response[0]['id'], publicUrl);
    }

    return isVerified; // Return the final verification status
  }

  Future<String> login() async {
    try {
      final credential = await firebaseAuth.FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController, password: passwordController);
      // final response = await Supabase.instance.client.auth.signInWithPassword(
      //   email: emailController,
      //   password: passwordController,
      // );

      // if (response.user != null) {
      //   return 'ok';
      // } else
      //   return 'error occured';
      return 'ok';
    } on firebaseAuth.FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }
}
