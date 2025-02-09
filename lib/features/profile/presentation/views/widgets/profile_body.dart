import 'dart:io';

import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:chat_app/features/profile/presentation/views/widgets/edit_name.dart';
import 'package:chat_app/features/profile/presentation/views/widgets/edit_phone.dart';
import 'package:chat_app/features/profile/presentation/views/widgets/photo.dart';
import 'package:chat_app/features/profile/presentation/views/widgets/save.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatefulWidget {
  ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  File? imageFile;

  @override
  Widget build(BuildContext context) {
    var provider = context.read<ConversationProvider>();
    usernameController.text = provider.sender!['name'];
    phoneController.text = provider.sender!['phone_num'];
    return SingleChildScrollView(
      child: Padding(
        padding:const EdgeInsets.only(left:20,right: 20),
        child: Column(
          children: [
            Photo(uploadedPhoto: imageFile,
                  onPhotoSelected: (File? newPhoto) {
                    setState(() {
                      imageFile = newPhoto; // Update the imageFile state
                    });
                  },),
            SizedBox(height: MediaQuery.of(context).size.height*0.2),
            EditName(usernameController: usernameController),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            EditPhone(phoneController: phoneController),
            SizedBox(height: MediaQuery.of(context).size.height*0.2),
            Save(phoneController: phoneController, usernameController: usernameController, imageFile: imageFile),
          ],
        ),
      ),
    );
  }
}