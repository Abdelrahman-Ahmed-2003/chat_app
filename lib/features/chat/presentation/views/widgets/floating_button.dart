import 'package:chat_app/core/state_managment/contacts_provider.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/all_contacts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<ContactsProvider>();
    return FloatingActionButton(
      onPressed: () async {
        debugPrint('get app contactssssssssssssssssssssss');
        
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AllContacts()));
        provider.getAppContacts(context);
      },
      child: const Icon(Icons.message),
    );
  }
}
