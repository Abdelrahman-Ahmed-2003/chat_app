import 'dart:convert';
import 'package:chat_app/core/model/status_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<StatusModel?> fetchSenderStatus(String phoneNum) async {
  try {
    final data = await supabase
        .from('status')
        .select(
            'file_paths, users!status_phone_num_fkey!inner(name,image)') // Explicit join using !inner
        .eq('phone_num', phoneNum)
        .maybeSingle();

    // Print results
    print('response of statussssssssssssssssss');
    print(data.toString());
    // Parse status paths
    if (data == null) return null;
    List<dynamic> rawStatusPaths = [];
    try {
      rawStatusPaths = jsonDecode(data['file_paths'] ?? '[]');
      print(rawStatusPaths.toString());
    } catch (e) {
      print('Error parsing status paths: $e');
    }

    // Convert raw paths to Details
    final statusDetails = rawStatusPaths.map<Details>((path) {
      return Details(
        type: path['type'],
        path: path['path'] ?? '',
        url: path['url'] ?? '',
        createdAt: path['created_at'] ?? '',
        endAt: path['expired_at'] ?? '',
      );
    }).toList();
    print('detailssssssssssssssssssssss');
    print(statusDetails.toString());
    return StatusModel(
      phoneNumber: phoneNum,
      name: data['users']['name'],
      profilePic: data['users']['image'] ?? '', // Assuming this column exists
      statusDetails: statusDetails,
    );
  } catch (e) {
    print('Fetch statuses error: $e');
    return null;
  }
}

Future<List<StatusModel>> fetchStatusUpdates(
    Map<String, String> appContacts) async {
  try {
    final data = await supabase
        .from('status')
        .select(
            'file_paths, users!status_phone_num_fkey!inner(image)') // Explicit join using !inner
        .inFilter('phone_num', appContacts.keys.toList());

    // Print results
    print('response of statussssssssssssssssss');
    print(data.toString());
    for (var status in data) {
      print(
          'User: ${status['users']['name']}, Profile Pic: ${status['users']['image']}');
    }

    return data.map<StatusModel>((status) {
      // Parse status paths
      List<dynamic> rawStatusPaths = [];
      try {
        rawStatusPaths = jsonDecode(status['file_paths'] ?? '[]');
      } catch (e) {
        print('Error parsing status paths: $e');
      }

      // Convert raw paths to Details
      final statusDetails = rawStatusPaths.map<Details>((path) {
        return Details(
          type: path['type'] ??
              (path['path'].contains('video') ? 'video' : 'image'),
          path: path['path'] ?? '',
          url: path['url'] ?? '',
          createdAt: path['created_at'] ?? '',
          endAt: path['expired_at'] ?? path['endAt'] ?? '',
        );
      }).toList();

      return StatusModel(
        phoneNumber: status['phone_num'],
        name: appContacts[status['phone_num']] ?? '',
        profilePic: status['image'] ?? '', // Assuming this column exists
        statusDetails: statusDetails,
      );
    }).toList();
  } catch (e) {
    print('Fetch statuses error: $e');
    return [];
  }
}

// Future<List<StatusModel>> fetchStatusUpdates(List<String> contacts) async {
//   final supabase = Supabase.instance.client;
//   try {
//     final response = await supabase
//         .from('status')
//         .select(
//             'file_paths, users!inner(name, image)') // Explicit join using !inner
//         .inFilter('phone_num', contacts); // Optional: Limit results

//     print('response of statussssssssssssssssss');
//     print(response.toString());
//     // Print results
//     for (var status in response) {
//       print(
//           'User: ${status['user']['name']}, Profile Pic: ${status['user']['profile_pic']}, File Paths: ${status['file_paths']}');
//     }
//     return response.map<StatusModel>((status) {
//       // Parse status paths
//       List<dynamic> rawStatusPaths = [];
//       try {
//         rawStatusPaths = jsonDecode(status['file_paths'] ?? '[]');
//       } catch (e) {
//         print('Error parsing status paths: $e');
//       }

//       // Convert raw paths to Details
//       final statusDetails = rawStatusPaths.map<Details>((path) {
//         return Details(
//           type: path['type'] ??
//               (path['path'].contains('video') ? 'video' : 'image'),
//           path: path['path'] ?? '',
//           url: path['url'] ?? '',
//           createdAt: path['created_at'] ?? '',
//           endAt: path['expired_at'] ?? path['endAt'] ?? '',
//         );
//       }).toList();

//       return StatusModel(
//         phoneNumber: status['phone_num'],
//         name: status['name'],
//         profilePic:
//             status['profile_picture'] ?? '', // Assuming this column exists
//         statusDetails: statusDetails,
//       );
//     }).toList();
//   } catch (e) {
//     print('Fetch statuses error: $e');
//     return [];
//   }
// }

// Future<List<StatusModel>> fetchStatuses() async {
//   try {
//     // Base query
//     var query = await supabase
//         .from('status')
//         .select('*')
//         .inFilter('phone_num', appContacts.keys.toList());

//     // Convert to StatusModel
//     print('queryyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
//     print(query.toString());
//     return query.map<StatusModel>((status) {
//       // Parse status paths
//       List<dynamic> rawStatusPaths = [];
//       try {
//         rawStatusPaths = jsonDecode(status['file_paths'] ?? '[]');
//       } catch (e) {
//         print('Error parsing status paths: $e');
//       }

//       // Convert raw paths to Details
//       final statusDetails = rawStatusPaths.map<Details>((path) {
//         return Details(
//           type: path['type'] ??
//               (path['path'].contains('video') ? 'video' : 'image'),
//           path: path['path'] ?? '',
//           url: path['url'] ?? '',
//           createdAt: path['created_at'] ?? '',
//           endAt: path['expired_at'] ?? path['endAt'] ?? '',
//         );
//       }).toList();

//       return StatusModel(
//         phoneNumber: status['phone_num'],
//         name: status['name'],
//         profilePic:
//             status['profile_picture'] ?? '', // Assuming this column exists
//         statusDetails: statusDetails,
//       );
//     }).toList();
//   } catch (e) {
//     print('Fetch statuses error: $e');
//     return [];
//   }
// }
