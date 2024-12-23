import 'package:chat_app/features/auth/presentation/views/widgets/check_contact.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/all_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        debugPrint('get app contactssssssssssssssssssssss');
        List<Contact> contacts = await getAppContacts(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AllContacts(
                      appContacts: contacts,
                    )));
      },
      child: const Icon(Icons.message),
    );
  }
}
