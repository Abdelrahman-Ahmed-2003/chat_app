import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String chatId;

  ChatPage({required this.chatId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Provider.of<ConversationProvider>(context, listen: false)
        .findConnection) {
      debugPrint('connection foundeddddddddddddddddddddddddddddddddddddddd');
      Provider.of<ConversationProvider>(context, listen: false)
          .listenToMessages(widget.chatId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConversationProvider>(context);
    debugPrint('chat iddddddddddddddddddddddddddddd is');
    debugPrint(widget.chatId);

    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              // reverse: true,
              itemCount: provider.messages.length,
              itemBuilder: (context, index) {
                final message = provider.messages[index];
                final isMine = message['sender'] == provider.sender?['id'];

                return Align(
                  alignment:
                      isMine ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: isMine ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(message['content']),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    
                    provider.sendMessage(
                        widget.chatId, _messageController.text.trim());
                    _messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
