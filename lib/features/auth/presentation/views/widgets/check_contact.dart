import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<Contact>> getAppContacts(BuildContext context) async {
  List<Contact> appContacts = [];

  try {
    // Step 1: Request permission to access contacts
    if (await FlutterContacts.requestPermission()) {
      // Step 2: Fetch contacts with phone numbers
      List<Contact> contacts =
          await FlutterContacts.getContacts(withProperties: true);

      var provider = await context.read<ConversationProvider>();

      // Step 3: Iterate over contacts and check if they use the app
      for (var contact in contacts) {
        for (var phone in contact.phones) {
          String phoneNumber = phone.number
              .trim()
              .replaceAll(' ', ''); // Clean up the phone number
          print('phone number is ' + phoneNumber);
          // Check if the phone number exists in the database
          String? reciverId = await checkContact(phoneNumber);
          print('phone sender isssssssssssssssssssssss');
          print(provider.sender?['phone_num']);
          if (reciverId != null &&
              provider.sender?['phone_num'] != phoneNumber) {
            appContacts.add(contact);
          }
        }
      }
    } else {
      print('Permission to access contacts denied.');
    }
  } catch (e) {
    print('Error fetching app contacts: $e');
  }

  return appContacts;
}

// Function to check if a phone number exists in the database
Future<String?> checkContact(String phone) async {
  try {
    final response = await Supabase.instance.client
        .from('users')
        .select()
        .eq('phone_num', phone)
        .maybeSingle();

    if (response != null) {
      return response['id'];
    }
  } catch (e) {
    print('Error checking contact: $e');
    return null;
  }
  return null;
}
