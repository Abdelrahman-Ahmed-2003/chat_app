import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<void> checkADeleteStatus() async {
  print('in deleteeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
  // Fetch all statuses
  final response = await supabase.from('status').select('*');

  print('response: ${response}');

  for (var user in response) {
    print('in user: $user');

    // Decode the file_paths from JSON string to List<Map<String, dynamic>>
    List<Map<String, dynamic>> filePaths = [];
    try {
      filePaths =
          List<Map<String, dynamic>>.from(jsonDecode(user['file_paths']));
    } catch (e) {
      print('Error decoding file_paths: $e');
      continue; // Skip this user if decoding fails
    }

    print('user file paths: $filePaths');

    List<Map<String, dynamic>> updatedFilePaths = [];

    for (var state in filePaths) {
      print('in state: $state');
      DateTime expiredAt = DateTime.parse(state['expired_at']);
      if (expiredAt.isBefore(DateTime.now())) {
        // Delete the media from Supabase Storage
        final mediaPath = state['path'];
        await supabase.storage.from('status').remove([mediaPath]);
        print('Deleted media at path: $mediaPath');
      } else {
        updatedFilePaths.add(state);
      }
    }

    // Update the status in the database if there are changes
    if (updatedFilePaths.length != filePaths.length) {
      await supabase.from('status').update({
        'file_paths': jsonEncode(updatedFilePaths),
      }).eq('id',
          user['id']); // Assuming there's an 'id' field to identify the status
    }
  }
}
