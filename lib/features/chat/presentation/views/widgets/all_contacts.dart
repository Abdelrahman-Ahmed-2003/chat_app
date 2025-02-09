import 'package:chat_app/core/state_managment/contacts_provider.dart';
import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:chat_app/features/chat_page/presentation/views/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllContacts extends StatelessWidget {
  const AllContacts({super.key});

  // make start in list view from 1 not zero because zero is my number
  @override
  Widget build(BuildContext context) {
    var contactsProvider = context.watch<ContactsProvider>();
    var conversationProvider = context.read<ConversationProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const Text('Contacts using What\'s App'),
                if (contactsProvider.contacts.isEmpty &&
                    contactsProvider.isLoading)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (contactsProvider.contacts.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text('No contacts are using the app.'),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final contactEntry =
                            contactsProvider.contacts.entries.elementAt(index);
                        final phoneNumber = contactEntry.key;
                        final contactName = contactEntry.value;

                        return InkWell(
                          onTap: () async {
                            var response =
                                await conversationProvider.fetchReceiverInfoBy(
                                    name: 'phone_num', value: phoneNumber);
                            conversationProvider.receivers = [response!];

                            final existingChatId =
                                await conversationProvider.findExistingChat();

                            // if (!context.mounted) return;

                            if (existingChatId != null) {
                              await conversationProvider
                                  .fetchChat(existingChatId);
                              print(
                                  'chat foundedddddddddddddddddddddddddddddddddddddddd');
                              print(conversationProvider.activeChat!.name);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChatPage(chatId: existingChatId),
                                ),
                              );
                            } else {
                              var response = await conversationProvider
                                  .fetchReceiverInfoBy(
                                      name: 'phone_num', value: phoneNumber);
                              if (conversationProvider.receivers != null)
                                conversationProvider.receivers!.clear();
                              conversationProvider.messageList.clear();
                              conversationProvider.receivers = [response!];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    nameOfContact: contactName,
                                  ),
                                ),
                              );
                            }
                          },
                          child: ListTile(
                            title: Text(contactName),
                            subtitle: Text(phoneNumber),
                          ),
                        );
                      },
                      itemCount: contactsProvider.contacts.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 10);
                      },
                    ),
                  ),
              ],
            ),
          ),
          if (contactsProvider.isLoading &&
              contactsProvider.contacts.isNotEmpty)
            Positioned(
              left: MediaQuery.sizeOf(context).width / 2.2,
              top: MediaQuery.sizeOf(context).height / 10,
              child: const CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
