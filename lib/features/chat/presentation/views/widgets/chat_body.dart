import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:chat_app/features/chat_page/presentation/views/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBody extends StatefulWidget {
  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final provider = Provider.of<ConversationProvider>(context, listen: false);
    await provider.fetchSender();
    print('phone number of sender issssssssssss');
    print(provider.sender!['phone_num']); // Fetch sender information
    await provider.fetchChats(); // Fetch chats for the sender
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConversationProvider>(context);

    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      itemCount: provider.chats.length,
      itemBuilder: (context, index) {
        final chat = provider.chats[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(
              chat.name.isNotEmpty ? chat.name[0].toUpperCase() : '?',
            ),
          ),
          title: Text(chat.name),
          subtitle: Text(
            chat.lastMessage.content ?? '',
          ),
          onTap: () {
            provider.findConnection = true;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatPage(chatId: chat.id),
              ),
            );
          },
        );
      },
    );
  }
}
