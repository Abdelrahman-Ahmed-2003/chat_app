import 'package:chat_app/core/model/chat_model.dart';
import 'package:chat_app/core/state_managment/contacts_provider.dart';
import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:chat_app/features/chat_page/presentation/views/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    print('in init stateeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
    _initializeChats();
  }

  void _initializeChats() async {
    final provider = Provider.of<ConversationProvider>(context, listen: false);
    final contactProvider =
        Provider.of<ContactsProvider>(context, listen: false);
    await provider.fetchSender();
    await provider.initializeChats(contactProvider.contacts);
  }

  @override
  Widget build(BuildContext context) {
    print('in chat bodyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');

    return Consumer<ConversationProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          controller: scrollController,
          itemCount: provider.chats.length,
          itemBuilder: (context, index) {
            final chat = provider.chats[index];
            return ChatListTile(chat: chat);
          },
        );
      },
    );
  }
}

// Separate widget for the list tile
class ChatListTile extends StatelessWidget {
  final ChatModel chat;

  const ChatListTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    print('chattttttttttttttttt imageeeeeeeeeeeeeeeeeeeeeeeeeeee');
    print(chat.image);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
            (chat.image!.isEmpty == false) ? NetworkImage(chat.image!) : null,
        child: (chat.image!.isEmpty == true)
            ? Text(chat.name.isNotEmpty ? chat.name[0].toUpperCase() : '?')
            : null,
      ),
      title: Text(chat.name),
      subtitle: Text(chat.lastMessage.content),
      onTap: () => _handleChatTap(context, chat),
    );
  }

  Future<void> _handleChatTap(BuildContext context, ChatModel chat) async {
    final provider = Provider.of<ConversationProvider>(context, listen: false);
    provider.findChat = true;

    List<String?> receiverPhones =
        await provider.fetchReceiversFromChatId(chatId: chat.chatId);
    print('receiver phones: $receiverPhones');

    await provider.setActiveChat(chat);

    if (receiverPhones.isNotEmpty) {
      List<Map<String,dynamic>> receivers = [];
      for (String? phone in receiverPhones) {
        var response = await provider.fetchReceiverInfoBy(
            name: 'phone_num', value: phone!);
        if (response != null) {
          receivers.add(response);
        }
      }
      provider.receivers = receivers;
      print(provider.receivers.toString());

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatPage(
            chatId: chat.chatId,
            nameOfContact: chat.name,
          ),
        ),
      );
    }
  }
}