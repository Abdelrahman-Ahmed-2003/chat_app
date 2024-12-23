import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:chat_app/features/chat_page/presentation/views/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:provider/provider.dart';

class AllContacts extends StatelessWidget {
  final List<Contact> appContacts; // Contacts that are using the app

  const AllContacts({super.key, required this.appContacts});

  @override
  Widget build(BuildContext context) {
    var conversationProvider = context.read<ConversationProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text('Contacts using What\'s App'),
            appContacts.isEmpty
                ? const Text('No contacts are using the app.')
                : Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final contact = appContacts[index];
                        final phoneNumber = contact.phones.first.number
                            .trim()
                            .replaceAll(" ", ""); // Normalize phone number

                        return InkWell(
                          onTap: () async {
                            // Check if a connection or chat already exists
                            final existingChatId = await conversationProvider
                                .findExistingConnection(phoneNumber);

                            if (existingChatId != null) {
                              // Navigate to the existing chat
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChatPage(chatId: existingChatId),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChatPage(chatId: phoneNumber),
                                ),
                              );
                            }
                          },
                          child: ListTile(
                            title: Text(contact.displayName),
                            subtitle: Text(phoneNumber),
                          ),
                        );
                      },
                      itemCount: appContacts.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
