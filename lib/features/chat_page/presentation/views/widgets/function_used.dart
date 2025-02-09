import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';

ChatController setChatController(ConversationProvider provider) {
  print('Provider message list:');
  print(provider.messageList);

  // Create a list of ChatUser for other users based on the receivers
  List<ChatUser> otherUsers = provider.receivers?.map((receiver) {
    return ChatUser(
      id: receiver['phone_num'], // Assuming phone_num is the unique identifier
      name: receiver['name'], // Assuming name is available
      // profilePhoto: Data.profileImage, // Uncomment if you have profile images
    );
  }).toList() ?? [];

  return ChatController(
    initialMessageList: provider.messageList,
    scrollController: ScrollController(),
    currentUser: ChatUser(
      id: provider.sender!['phone_num'],
      name: provider.sender!['name'],
      // profilePhoto: Data.profileImage, // Uncomment if you have profile images
    ),
    otherUsers: otherUsers, // Set the dynamically created list of other users
  );
}