import 'dart:io';

import 'package:chat_app/core/sharedWidgets/custom_button.dart';
import 'package:chat_app/core/state_managment/conversation_provider.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/photo.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/username_field.dart';
import 'package:chat_app/features/chat/presentation/views/widgets/upload_group_photo.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameAndPhoto extends StatefulWidget {
  final Set<Map<String, dynamic>> members;
  const NameAndPhoto({
    super.key,
    required this.members,
  });
  @override
  State<NameAndPhoto> createState() => _NameAndPhotoState();
}

class _NameAndPhotoState extends State<NameAndPhoto> {
  var textController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? uploadedPhoto;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Photo(
                  uploadedPhoto: uploadedPhoto,
                  onPhotoSelected: (File? newPhoto) {
                    setState(() {
                      uploadedPhoto = newPhoto; // Update the imageFile state
                    });
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                UsernameField(usernameController: textController),
                const Spacer(),
                CustomButton(
                    text: 'Create Group',
                    func: () async {
                      if (formKey.currentState!.validate()) {
                        var provider = context.read<ConversationProvider>();

                        Message emptyMessage = Message(
                          id: '', // Generate a unique ID if necessary
                          message: '', // Empty message content
                          createdAt: DateTime.now(), // Set to the current time
                          sentBy: provider.sender![
                              'phone_num'], // The ID of the user sending the message
                        );
                        // Create a new conversation with the empty message
                        var conversationId =
                            await provider.createConversation(emptyMessage);
                        // Create a new chat with the conversation ID and the empty message
                        var chatId = await provider.createChat(
                          conversationId!,
                          emptyMessage,
                          textController.text,
                          true,
                          null,
                        );
                        if (provider.receivers != null) {
                          provider.receivers!.clear();
                        }
                        provider.receivers = widget.members.toList();
                        await provider.createUserChat(chatId!);
                        if (uploadedPhoto != null) {
                          var publicUrl = await uploadMediaToSupabase(
                              uploadedPhoto!, chatId);
                          await updateChatImage(chatId, publicUrl);
                        }
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
