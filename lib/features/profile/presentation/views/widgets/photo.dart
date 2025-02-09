import 'dart:io';
import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/upload_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Photo extends StatelessWidget {
  final File? uploadedPhoto;
  final Function(File?) onPhotoSelected; // Callback to update the photo

  const Photo({super.key, required this.uploadedPhoto, required this.onPhotoSelected});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<ConversationProvider>();
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80.r,
            backgroundImage: uploadedPhoto == null
                ? (provider.sender!['image'] == null?const AssetImage('assets/images/person.png'):NetworkImage(provider.sender!['image']))
                : FileImage(uploadedPhoto!), // Use FileImage for the uploaded photo
          ),
          Positioned(
            bottom: 0,
            right: 1,
            child: Container(
              height: 20.h,
              width: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: Colors.green,
                  width: 2.w,
                ),
              ),
              child: Center(
                child: IconButton(
                  padding: EdgeInsets.zero, // Remove default padding
                  constraints: const BoxConstraints(), // Remove default constraints
                  onPressed: () async {
                    // Call the function to upload the photo
                    File? newPhoto = await handleUserPhotoUpload(context);
                    onPhotoSelected(newPhoto); // Update the photo in the parent
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.green,
                    size: MediaQuery.of(context).size.height * 0.018,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}