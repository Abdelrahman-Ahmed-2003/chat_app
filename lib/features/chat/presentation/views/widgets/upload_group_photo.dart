import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;

// Function to pick an image
Future<File?> pickImage(ImageSource source) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);
  
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null; // Return null if no image was picked
}

// Function to generate upload path for user photo
String generateUploadPath(File file, String id) {
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final fileName = path.basename(file.path);
  return '$id/${timestamp}_$fileName';
}

// Function to upload media to Supabase Storage
Future<String?> uploadMediaToSupabase(File file, String id) async {
  final supabase = Supabase.instance.client;
  final uploadPath = generateUploadPath(file, id);

  try {
    await supabase.storage.from('group_photo').upload(uploadPath, file);
    return supabase.storage.from('group_photo').getPublicUrl(uploadPath);
  } catch (error) {
    debugPrint('Error uploading media: $error');
    return null; // Return null if upload fails
  }
}

// Function to update user profile with the uploaded photo URL
Future<void> updateChatImage(String id, String? photoUrl) async {
  if (photoUrl == null) return; // Exit if no URL is provided

  final supabase = Supabase.instance.client;
  await supabase.from('chat').update({
    'image': photoUrl, // Assuming you have a 'profile_photo' column
  }).eq('chat_id', id);
}

// Main function to handle the entire process
Future<File?> handleChatPhotoUpload(BuildContext context) async {
  // Pick an image
  File? selectedMedia = await pickImage(ImageSource.gallery);
  
  if (selectedMedia == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select a media file first')),
    );
    return null; // Return null if no media was selected
  }
  return selectedMedia; // Return the selected media file
}