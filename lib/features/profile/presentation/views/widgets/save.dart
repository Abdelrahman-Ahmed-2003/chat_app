import 'dart:io';

import 'package:chat_app/core/sharedWidgets/custom_button.dart';
import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Save extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  File? imageFile;
  Save({
    super.key,
    required this.phoneController,
    required this.usernameController,
    required this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        text: 'save profile',
        func: () async {
          if (usernameController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Please enter your name',style: TextStyle(fontSize: 20.sp),),
              //backgroundColor: Colors.red,
            ));
          }else if (phoneController.text.isEmpty ||
              phoneController.text.length != 11 ||
              RegExp(r'\D').hasMatch(phoneController.text)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Please enter vaild phone number containing only digits',style: TextStyle(fontSize: 20.sp),),
              //backgroundColor: Colors.red,
            ));
          }else {
            var provider = context.read<ConversationProvider>();
            await provider.updateSenderData(usernameController.text, phoneController.text, imageFile);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Data is saved successfully',style: TextStyle(fontSize: 20.sp),),
              //backgroundColor: Colors.red,
            ));
          }
        });
  }
}