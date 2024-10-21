import 'package:chat_app/features/chat/presentation/views/widgets/chat_body.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/floating_button.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

 @override
Widget build(BuildContext context) {
  return const SafeArea(
    child: Scaffold(
      floatingActionButton: FloatingButton(),
      body:ChatBody(),
    ),
  );
}
}
