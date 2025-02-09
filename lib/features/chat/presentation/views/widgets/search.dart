import 'package:chat_app/core/model/chat_model.dart';
import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:chat_app/features/chat_page/presentation/views/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var controller = TextEditingController();
  List<ChatModel>chatModel = [];
  @override
  Widget build(BuildContext context) {
  var provider = context.read<ConversationProvider>();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextFormField(
              onChanged: (value) => setState(() {
                chatModel = provider.chats.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
              }),
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chatModel.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatPage(chatId:chatModel[index].chatId))),
                    child: ListTile(
                      title: Text(chatModel[index].name),
                      subtitle: Text(chatModel[index].lastMessage.content),
                      // leading: CircleAvatar(
                      //   backgroundImage: NetworkImage(chatModel[index].image),
                      // ),
                    ),
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
