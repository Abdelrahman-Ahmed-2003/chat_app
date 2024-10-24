import 'package:chat_app/features/profile/presentation/views/widgets/edit_name.dart';
import 'package:chat_app/features/profile/presentation/views/widgets/edit_phone.dart';
import 'package:chat_app/features/profile/presentation/views/widgets/photo.dart';
import 'package:chat_app/features/profile/presentation/views/widgets/save.dart';
import 'package:flutter/material.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    usernameController.text = 'Abdelrahman Ahmed';
    phoneController.text = '+201144799032';
    return SingleChildScrollView(
      child: Padding(
        padding:const EdgeInsets.only(left:20,right: 20),
        child: Column(
          children: [
            const Photo(),
            SizedBox(height: MediaQuery.of(context).size.height*0.2),
            EditName(usernameController: usernameController),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            EditPhone(phoneController: phoneController),
            SizedBox(height: MediaQuery.of(context).size.height*0.2),
            Save(phoneController: phoneController, usernameController: usernameController),
          ],
        ),
      ),
    );
  }
}