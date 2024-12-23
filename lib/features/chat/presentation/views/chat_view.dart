import 'package:chat_app/features/chat/presentation/views/widgets/chat_body.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/chat_view_appbar.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/floating_button.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: const ChatViewAppbar(),
    floatingActionButton: FloatingButton(),
    body:Padding(
      padding: const EdgeInsets.all(16.0),
      child: ChatBody(),
    ),
  );
}
}
