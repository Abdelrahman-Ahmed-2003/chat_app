import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:chat_app/features/chat_page/presentation/views/widgets/function_used.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String chatId;
  final String nameOfContact;

  const ChatPage({super.key, this.chatId = '', this.nameOfContact = ''});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatController? chatController;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    var provider = Provider.of<ConversationProvider>(context, listen: false);
    provider.messageList.clear();
    if (provider.findChat) {
      debugPrint('Connection found. Fetching conversation...');
      await provider.listenToConversation(widget.chatId);
    } else {
      debugPrint('No connection found.');
    }
    setState(() {
      debugPrint('Setting chat controller...');
      chatController = setChatController(provider);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ConversationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: (provider.activeChat?.image != null &&
                      provider.activeChat!.image!.isNotEmpty)
                  ? NetworkImage(provider.activeChat!.image!)
                  : null,
              child: (provider.activeChat?.image == null ||
                      provider.activeChat!.image!.isEmpty)
                  ? Text(
                      provider.activeChat?.name.isNotEmpty == true
                          ? provider.activeChat!.name[0].toUpperCase()
                          : '?',
                    )
                  : null,
            ),
            const SizedBox(width: 10),
            Text(widget.nameOfContact),
          ],
        ),
      ),
      body: Consumer<ConversationProvider>(
        builder: (context, provider, child) {
          debugPrint('Message List: ${provider.messageList.length}');
          debugPrint('Chat Controller: $chatController');

          if (chatController != null) {
            chatController!.initialMessageList = provider.messageList;
            return ChatView(
              sendMessageConfig: const SendMessageConfiguration(
                textFieldConfig: TextFieldConfiguration(
                  textStyle: TextStyle(color: Colors.black),
                  enabled: true,
                ),
              ),
              onSendTap: (message, replyMessage, messageType) => _onSendTap(
                provider,
                chatController!,
                message,
                replyMessage,
                messageType,
              ),
              featureActiveConfig: const FeatureActiveConfig(
                enableSwipeToReply: true,
              ),
              chatController: chatController!,
              chatViewState: provider.messageList.isEmpty
                  ? ChatViewState.loading
                  : ChatViewState.hasMessages,
            );
          } else {
            // Instead of showing a CircularProgressIndicator, show a message or an empty state widget
            return Center(
              child: Text(
                'No messages yet. Start a conversation!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }

  void _onSendTap(
    ConversationProvider provider,
    ChatController chatController,
    String message,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) async {
    var mes = Message(
      id: DateTime.now().toString(),
      createdAt: DateTime.now(),
      message: message,
      sentBy: chatController.currentUser.id,
      replyMessage: replyMessage,
      messageType: messageType,
    );

    if (!provider.findChat) {
      String? convId = await provider.createConversation(mes);
      String? chatId = await provider.createChat(
          convId!, mes, widget.nameOfContact, false, null);
      await provider.createUserChat(chatId!);
      provider.listenToConversation(chatId);
      provider.sendMessage(mes);
      provider.findChat = true;
    } else {
      provider.sendMessage(mes);
    }
    chatController.addMessage(mes);
  }
}
