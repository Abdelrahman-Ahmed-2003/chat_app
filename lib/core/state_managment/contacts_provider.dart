import 'package:flutter/material.dart';
import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContactsProvider extends ChangeNotifier {
  Map<String, String> _contacts = {};
  bool _isLoading = false;
  

  Map<String, String> get contacts => _contacts;
  bool get isLoading => _isLoading;

  void clear(){
    _contacts.clear();
    notifyListeners();
  }
  Future<void> getAppContacts(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      if (await FlutterContacts.requestPermission()) {
        final provider = context.read<ConversationProvider>();

        List<Contact> allContacts =
            await FlutterContacts.getContacts(withProperties: true);

        for (var contact in allContacts) {
          print('contact name issssssssssssssssssssssssssss');
          print(contact.displayName);
          print(contact.phones.toString());
          for (var phone in contact.phones) {
            String phoneNumber = phone.number.trim().replaceAll(' ', '');
            String? reciverId = await checkContact(phoneNumber);
            if (reciverId != null &&
                provider.sender?['phone_num'] != phoneNumber) {
              if (_contacts[phoneNumber] == contact.displayName) {
                continue;
              } else {
                // Add new contact and notify immediately
                _contacts[phoneNumber] = contact.displayName;
                notifyListeners();
              } // This will update the UI for each new contact
            }
          }
        }
      } else {
        print('Permission to access contacts denied.');
      }
    } catch (e) {
      print('Error fetching app contacts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
        return response['phone_num'];
      }
    } catch (e) {
      print('Error checking contact: $e');
      return null;
    }
    return null;
  }
}
