import 'package:chat_app/core/state_managment/contacts_provider.dart';
import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/create_new_group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({super.key});

  @override
  _NewGroupState createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  // Set to keep track of selected contacts
  final Set<Map<String, dynamic>> selectedContacts = {};

  @override
  Widget build(BuildContext context) {
    var provider = context.read<ContactsProvider>();
    var conversationProvider = context.read<ConversationProvider>();

    return Scaffold(
      floatingActionButton:
          createNewGroupFloatingActionButton(context, selectedContacts),
      appBar: AppBar(
        title: const Text('New Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            if (provider.contacts.isEmpty)
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
                        provider.contacts.entries.elementAt(index);
                    final phoneNumber = contactEntry.key;
                    final contactName = contactEntry.value;

                    // Check if the contact is selected
                    bool isSelected = selectedContacts
                        .any((contact) => contact['phone_num'] == phoneNumber);

                    return InkWell(
                      onTap: () async {
                        try {
                          final data = await conversationProvider.fetchReceiverInfoBy(
                            name: 'phone_num',
                            value: phoneNumber,
                          );
                          
                          setState(() {
                            if (isSelected) {
                              selectedContacts.removeWhere(
                                  (contact) => contact['phone_num'] == phoneNumber);
                            } else {
                              selectedContacts.add(data!);
                            }
                          });
                        } catch (e) {
                          debugPrint('Error fetching receiver info: $e');
                        }
                      },
                      child: ListTile(
                        title: Text(contactName),
                        subtitle: Text(phoneNumber),
                        tileColor: isSelected ? Colors.green[100] : null,
                        trailing: Checkbox(
                          value: isSelected,
                          onChanged: (bool? value) async {
                            try {
                              if (value == true) {
                                final data =
                                    await conversationProvider.fetchReceiverInfoBy(
                                  name: 'phone_num',
                                  value: phoneNumber,
                                );
                                setState(() {
                                  selectedContacts.add(data!);
                                });
                              } else {
                                setState(() {
                                  selectedContacts.removeWhere((contact) =>
                                      contact['phone_num'] == phoneNumber);
                                });
                              }
                            } catch (e) {
                              debugPrint('Error updating selection: $e');
                            }
                          },
                        ),
                      ),
                    );
                  },
                  itemCount: provider.contacts.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}