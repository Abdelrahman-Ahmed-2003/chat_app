import 'dart:convert';
import 'dart:io';
import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;

class MediaUploadPage extends StatefulWidget {
  const MediaUploadPage({super.key});

  @override
  _MediaUploadPageState createState() => _MediaUploadPageState();
}

class _MediaUploadPageState extends State<MediaUploadPage> {
  final supabase = Supabase.instance.client;
  File? _selectedMedia;
  bool _isUploading = false;
  String? _uploadedFileUrl;

  // Generate Upload Path
  String _generateUploadPath(File file, String phoneNumber) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = path.basename(file.path);
    final fileExtension = path.extension(file.path).toLowerCase();

    // Determine media type
    final mediaType = fileExtension == '.mp4' ? 'videos' : 'images';

    // Construct path: status/users/{phoneNumber}/{mediaType}/{timestamp}_filename
    return 'users/$phoneNumber/$mediaType/${timestamp}_$fileName';
  }

  // Media Picker Method
  Future<void> _pickMedia(ImageSource source, {bool isVideo = false}) async {
    final picker = ImagePicker();
    XFile? pickedFile;

    if (isVideo) {
      pickedFile = await picker.pickVideo(source: source);
    } else {
      pickedFile = await picker.pickImage(source: source);
    }

    if (pickedFile != null) {
      setState(() {
        _selectedMedia = File(pickedFile!.path);
      });
    }
  }

  // Handle Storage Errors
  void _handleStorageError(dynamic error) {
    String errorMessage = 'An unknown error occurred';

    if (error is StorageException) {
      errorMessage = error.message;
    } else
      errorMessage = error.message;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }

  // Upload Media to Supabase Storage
Future<void> _uploadMediaToSupabase() async {
  final provider = Provider.of<ConversationProvider>(context, listen: false);
  final phoneNumber = provider.sender!['phone_num'];
  final userName = provider.sender!['name'];

  if (_selectedMedia == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select a media file first')),
    );
    return;
  }

  setState(() {
    _isUploading = true;
  });

  try {
    // Generate upload path
    final uploadPath = _generateUploadPath(_selectedMedia!, phoneNumber);

    // Determine file type
    final fileExtension = path.extension(_selectedMedia!.path).toLowerCase();
    final fileType = fileExtension == '.mp4' ? 'video' : 'image';

    // Upload to Supabase Storage
    await supabase.storage.from('status').upload(
          uploadPath,
          _selectedMedia!,
        );

    // Get public URL
    final publicUrl =
        supabase.storage.from('status').getPublicUrl(uploadPath);

    // Fetch existing status for the user
    final existingStatusResponse = await supabase
        .from('status')
        .select('file_paths')
        .eq('phone_num', phoneNumber)
        .maybeSingle();

    // Prepare file paths
    List<dynamic> filePaths = [];
    print(existingStatusResponse?.toString());

    // If user already has a status, get existing paths
    if (existingStatusResponse != null &&
        existingStatusResponse['file_paths'] != null) {
      try {
        // Parse existing file paths
        filePaths = jsonDecode(existingStatusResponse['file_paths']);
        print('Existing file paths: $filePaths');
      } catch (e) {
        print('Error parsing existing file paths: $e');
        filePaths = [];
      }
    } else {
      print('No existing status found for this phone number.');
    }

    // Prepare new status path
    final newStatusPath = {
      'type': fileType,
      'path': uploadPath,
      'url': publicUrl,
      'created_at': DateTime.now().toIso8601String(),
      'expired_at':
          DateTime.now().add(const Duration(hours: 24)).toIso8601String(),
    };

    // Add new status path
    filePaths.add(newStatusPath);

    // Upsert status in database
    if (existingStatusResponse != null) {
      // Update existing entry
      await supabase.from('status').update({
        'file_paths': jsonEncode(filePaths),
      }).eq('phone_num', phoneNumber);
    } else {
      // Insert new entry
      await supabase.from('status').insert({
        'phone_num': phoneNumber,
        'file_paths': jsonEncode(filePaths),
      });
    }

    setState(() {
      _uploadedFileUrl = publicUrl;
      _isUploading = false;
      _selectedMedia = null; // Clear selected media after upload
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Media uploaded successfully!')),
    );
  } catch (error) {
    setState(() {
      _isUploading = false;
    });

    _handleStorageError(error);
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status Upload')),
      body: Column(
        children: [
          // Media Selection Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => _pickMedia(ImageSource.gallery),
                icon: const Icon(Icons.photo),
                label: const Text('Pick Image'),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () => _pickMedia(ImageSource.gallery, isVideo: true),
                icon: const Icon(Icons.video_library),
                label: const Text('Pick Video'),
              ),
            ],
          ),

          // Camera Capture Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => _pickMedia(ImageSource.camera),
                icon: const Icon(Icons.camera),
                label: const Text('Capture Image'),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () => _pickMedia(ImageSource.camera, isVideo: true),
                icon: const Icon(Icons.videocam),
                label: const Text('Record Video'),
              ),
            ],
          ),

          // Selected Media Preview
          if (_selectedMedia != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _selectedMedia!.path.endsWith('.mp4')
                  ? Text(
                      'Video Selected: ${path.basename(_selectedMedia!.path)}')
                  : Image.file(
                      _selectedMedia!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),

          // Upload Button
          if (_selectedMedia != null)
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadMediaToSupabase,
              child: _isUploading
                  ? const CircularProgressIndicator()
                  : const Text('Upload Media'),
            ),
        ],
      ),
    );
  }
}
