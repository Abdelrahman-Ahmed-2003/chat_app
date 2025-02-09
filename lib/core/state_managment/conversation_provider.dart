import 'dart:async';
import 'dart:io';
import 'package:chat_app/core/model/chat_model.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/upload_photo.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConversationProvider extends ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<ChatModel> chats = [];
  bool isLoading = false;
  bool findChat = false;
  List<Message> messageList = [];
  ChatModel? activeChat;
  Map<String, dynamic>? sender;
  List<Map<String, dynamic>>? receivers;

  StreamSubscription<dynamic>? _messageSubscription;
  StreamSubscription<List<Map<String, dynamic>>>? _chatSubscription;

  bool _isInitialized = false; // Prevent re-initialization

  Future<void> setActiveChat(ChatModel chat) async {
    activeChat = chat;
  }

  Future<void> setActiveChatFromMap(Map<String, dynamic> chat) async {
    activeChat = ChatModel.fromJson(chat);
  }

  Future<Map<String, dynamic>?> fetchReceiverInfoBy({
    required String name,
    required String value,
  }) async {
    try {
      final response =
          await supabase.from('users').select('*').eq(name, value).single();
      return response;
    } catch (e) {
      debugPrint('Error fetching receiver ID: $e');
      return null;
    }
  }

  Future<void> updateSenderData(
      String name, String phone, File? imageFile) async {
    sender!['name'] = name;
    sender!['phone_num'] = phone;
    var response = await supabase.from('users').update({
      'name': name,
      'phone_num': phone,
    }).eq('id', sender!['id']);
    if (imageFile != null) {
      print('iddddddddddddddddddddddddddddddddddddddddddddddddddddd');
      print(response[0]['id']);
      final supabase = Supabase.instance.client;

      // Construct the path to the photo
      final pathToDelete =
          'users/${response[0]['id']}/profile_photos/'; // Adjust this path as necessary

      // Delete the file from Supabase storage
      await supabase.storage.from('user_photo').remove([pathToDelete]);
      var publicUrl = await uploadMediaToSupabase(imageFile, response[0]['id']);
      await updateUserProfile(response[0]['id'], publicUrl);
    }
    notifyListeners();
  }

  // Fetch a single receiver from chat ID (for individual chats)
  Future<List<String?>> fetchReceiversFromChatId(
      {required String chatId}) async {
    try {
      final response = await supabase
          .from('user_chat')
          .select('user_phone')
          .eq('chat_id', chatId);
      List<String> phones = [];
      for (var item in response) {
        if (item['user_phone'] != sender!['phone_num']) {
          phones.add(item['user_phone']);
        }
      }
      // Assuming the first entry is the sender, return the second entry as the receiver
      // if (response[0]['user_phone'] != sender!['phone_num']) {
      //   return response[0]['user_phone'];
      // } else {
      //   return response[1]['user_phone'];
      // }
      return phones;
    } catch (e) {
      debugPrint('Error fetching receiver ID: $e');
      return [];
    }
  }

// Fetch groups from chat ID (for group chats)
  Future<List<String>?> fetchGroupsFromChatId({required String chatId}) async {
    try {
      final response = await supabase
          .from('user_chat')
          .select('user_phone')
          .eq('chat_id', chatId);

      // Return a list of group names
      return response.map((group) => group['group_name'] as String).toList();
    } catch (e) {
      debugPrint('Error fetching group names: $e');
      return null;
    }
  }

  // Check for existing connection
  Future<String?> findExistingChat() async {
    if (sender == null) {
      await fetchSender();
    }
    findChat = false;
    try {
      final user1Chats = await supabase
          .from('user_chat')
          .select('chat_id')
          .filter('user_phone', 'eq', sender!['phone_num']);

      final receiverPhones =
          receivers!.map((receiver) => receiver['phone_num']).toList();
      final user2Chats = await supabase
          .from('user_chat')
          .select('chat_id')
          .inFilter('user_phone',
              receiverPhones); // Use inFilter for multiple receivers

      // Extract chat IDs
      final user1ChatIds = user1Chats.map((chat) => chat['chat_id']).toSet();
      final user2ChatIds = user2Chats.map((chat) => chat['chat_id']).toSet();

      // Check for intersection
      final intersection = user1ChatIds.intersection(user2ChatIds);
      final hasChat = intersection.isNotEmpty;
      if (hasChat) {
        findChat = true;
        return intersection.first;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error during query: $e');
      return null;
    }
  }

  Future<String?> createConversation(Message mes) async {
    final response = await supabase
        .from('conversations')
        .insert({
          'messages': [mes], // Insert the message as a list
        })
        .select('conversation_id')
        .single();
    return response['conversation_id'];
  }

  Future<String?> createChat(String conversationId, Message lastMessage,
      String name, bool isGroup, String? image) async {
    if (sender == null) {
      await fetchSender();
    }
    try {
      final response = await supabase
          .from('chat')
          .insert({
            'name': isGroup ? name : null, // Customize chat name if needed
            'image': image, // Add an image if required
            'last_message': lastMessage, // Empty initially
            'conversation_id': conversationId,
            'is_group': isGroup,
          })
          .select()
          .single();
      await setActiveChatFromMap(response);
      return response['chat_id'];
    } catch (e) {
      debugPrint('Error creating connection: ${e.toString()}');
      return null;
    }
  }

  // Create user chat for multiple receivers
  Future<void> createUserChat(String chatId) async {
    try {
      await supabase.from('user_chat').insert({
        'user_phone': sender!['phone_num'],
        'chat_id': chatId,
      });

      // Insert all receivers into user_chat
      for (var receiver in receivers!) {
        await supabase.from('user_chat').insert({
          'user_phone': receiver['phone_num'],
          'chat_id': chatId,
        });
      }
    } catch (e) {
      debugPrint('Error creating user chat: $e');
    }
  }

  // Fetch sender details
  Future<void> fetchSender() async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        final response = await supabase
            .from('users')
            .select('*')
            .eq('email', currentUser.email!)
            .single();
        sender = response;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching sender: $e');
    }
  }

  Future<void> fetchInitialMessages(String chatId) async {
    try {
      // Get conversation ID from chatId
      String? conversationId = await getConversationIdFromChatId(chatId);
      if (conversationId == null) {
        debugPrint('No conversation ID found for chatId: $chatId');
        return;
      }

      // Fetch initial messages
      final response = await supabase
          .from('conversations')
          .select()
          .eq('conversation_id', conversationId)
          .single();

      if (response != null && response['messages'] != null) {
        messageList.clear();
        List<dynamic> messages =
            List<Map<String, dynamic>>.from(response['messages'] ?? []);

        for (var message in messages) {
          var replyMessageData = message['reply_message'];
          ReplyMessage replyMessage = ReplyMessage(
            messageId: replyMessageData?['id'],
            message: replyMessageData?['message'],
            replyBy: replyMessageData?['replyBy'],
            replyTo: replyMessageData?['replyTo'],
            messageType: replyMessageData?['message_type'] == 'text'
                ? MessageType.text
                : MessageType.voice,
            voiceMessageDuration: replyMessageData?['voice_message_duration'],
          );

          Message newMessage = Message(
            replyMessage: replyMessage,
            id: message['id'],
            message: message['message'],
            createdAt: DateTime.parse(message['createdAt']),
            sentBy: message['sentBy'],
          );

          messageList.add(newMessage);
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching initial messages: $e');
    }
  }

  // Start listening for new messages
  Future<void> listenToConversation(String chatId) async {
    // Cancel any existing subscriptions before starting a new one
    _messageSubscription?.cancel();

    // Get conversation ID from chatId
    String? conversationId = await getConversationIdFromChatId(chatId);
    if (conversationId == null) {
      debugPrint('No conversation ID found for chatId: $chatId');
      return;
    }

    // Start listening to messages for the given conversation ID
    _messageSubscription = supabase
        .from('conversations')
        .stream(primaryKey: ['id'])
        .eq('conversation_id', conversationId)
        .listen((data) {
          if (data.isNotEmpty) {
            List<dynamic> messages =
                List<Map<String, dynamic>>.from(data.first['messages'] ?? []);

            // Only process messages that aren't already in messageList
            for (var message in messages) {
              if (!messageList.any((m) => m.id == message['id'])) {
                var replyMessageData = message['reply_message'];
                ReplyMessage replyMessage = ReplyMessage(
                  messageId: replyMessageData?['id'],
                  message: replyMessageData?['message'],
                  replyBy: replyMessageData?['replyBy'],
                  replyTo: replyMessageData?['replyTo'],
                  messageType: replyMessageData?['message_type'] == 'text'
                      ? MessageType.text
                      : MessageType.voice,
                  voiceMessageDuration:
                      replyMessageData?['voice_message_duration'],
                );

                Message newMessage = Message(
                  replyMessage: replyMessage,
                  id: message['id'],
                  message: message['message'],
                  createdAt: DateTime.parse(message['createdAt']),
                  sentBy: message['sentBy'],
                );

                messageList.add(newMessage);
              }
            }
            print('last lineeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
            print(messageList.length);
            notifyListeners();
          }
        }, onError: (error) {
          debugPrint('Error listening to conversation: $error');
        });
  }

  Future<void> initializeChats(Map<String, String> contacts) async {
    if (_isInitialized) return; // Prevent re-initialization
    _isInitialized = true;

    try {
      if (sender == null) {
        await fetchSender();
      }

      // Cancel existing subscription if any
      if (_chatSubscription != null) {
        await _chatSubscription!.cancel();
      }

      // Start listening to user_chat changes
      final userChatStream = supabase
          .from('user_chat')
          .stream(primaryKey: ['id']).eq('user_phone', sender!['phone_num']);

      userChatStream.listen((userChatData) async {
        List<String> chatIds =
            userChatData.map((e) => e['chat_id'] as String).toList();

        // Update chat subscription when user_chat changes
        await _updateChatSubscription(chatIds, contacts);
      });
    } catch (e) {
      debugPrint('Error initializing chats: $e');
    }
  }

  Future<void> _updateChatSubscription(
      List<String> chatIds, Map<String, String> contacts) async {
    try {
      // Cancel existing chat subscription if any
      await _chatSubscription?.cancel();

      // Create new subscription
      _chatSubscription = supabase
          .from('chat')
          .stream(primaryKey: ['id'])
          .inFilter('chat_id', chatIds)
          .listen((chatModels) async {
            await _processChatUpdates(chatModels, contacts);
          });
    } catch (e) {
      debugPrint('Error updating chat subscription: $e');
    }
  }

  Future<void> _processChatUpdates(
      List<dynamic> chatModels, Map<String, String> contacts) async {
    try {
      List<ChatModel> newChats = [];
      for (var chat in chatModels) {
        List<String?> phones = await fetchReceiversFromChatId(chatId: chat['chat_id']);
        for(String? phone in phones){
          if (phone != null) {
          if (chat['is_group'] == false) {
            String contactName = await _getContactName(phone, contacts);
            print(
                'nammmmmmmeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
            print(chat['name']);
            print(contactName);
            // Update chat name if it's different

            chat['name'] = contactName;

            var userImage = await supabase
                .from('users')
                .select('image')
                .eq('phone_num', phone)
                .single();
            chat['image'] = userImage['image'];
            print(
                'in linstnerrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
            print(userImage['image']);
          }

          newChats.add(ChatModel.fromJson(chat));
        }
        }
      }
      // Only update and notify if there are actual changes
      if (!_areChatsEqual(chats, newChats)) {
        chats = newChats;
        print(
            'Updating chat listttttttttttttttttttttttttttttttttttttttttttttttttttttttttt...');
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error processing chat updates: $e');
    }
  }

  // Other methods remain unchanged...

  @override
  void dispose() {
    _chatSubscription?.cancel();
    _messageSubscription?.cancel();
    super.dispose();
  }

  // Add this method to handle contact name checking
  Future<String> _getContactName(
      String phone, Map<String, String> contacts) async {
    if (contacts[phone] == null || contacts[phone]!.isEmpty) {
      var receiver = await fetchReceiverInfoBy(name: 'phone_num', value: phone);
      return receiver?['name'] ?? '';
    }
    return contacts[phone]!;
  }

  // Helper method to compare chat lists
  bool _areChatsEqual(List<ChatModel> list1, List<ChatModel> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i].lastMessage.content != list2[i].lastMessage.content) {
        print(list1[i].chatId + '      ' + list2[i].chatId);
        print(list1[i].name + '      ' + list2[i].name);
        print('${list1[i].lastMessage}      ${list2[i].lastMessage}');
        return false;
      }
    }
    return true;
  }
  // Single method to handle both initial fetch and updates

  Future<String?> getConversationIdFromChatId(String chatId) async {
    try {
      final response = await supabase
          .from('chat')
          .select()
          .eq('chat_id', chatId)
          .maybeSingle();

      if (response == null) {
        return null;
      }
      // await setActiveChat(response);
      final idMessage = response['conversation_id'] as String?;
      return idMessage;
    } catch (e) {
      return null;
    }
  }

  // Create conversation

  // Send a message
  Future<void> sendMessage(Message message) async {
    debugPrint('in send message function');
    try {
      // Retrieve the existing messages or initialize with an empty list
      final existingMessagesResponse = await supabase
          .from('conversations')
          .select('messages')
          .eq('conversation_id', activeChat!.conversationId)
          .single();

      final existingMessages =
          (existingMessagesResponse['messages'] as List<dynamic>?) ?? [];
      final updatedMessages = [...existingMessages, message];
      await supabase
          .from('conversations')
          .update({'messages': updatedMessages}).eq(
              'conversation_id', activeChat!.conversationId);
      debugPrint('Message added to existing chat.');
      await supabase.from('chat').update({
        'last_message': message,
      }).eq('chat_id', activeChat!.chatId);
    } catch (e) {
      debugPrint('Error sending message: $e');
    }
  }

  Future<void> fetchChat(String chatId) async {
    final response =
        await supabase.from('chat').select().eq('chat_id', chatId).single();
    activeChat = ChatModel.fromJson(response);
  }

  void clear() {
    chats.clear();
    messageList.clear();
    sender = null;
    receivers = null;
    isLoading = false;
    findChat = false;
    notifyListeners();
  }
}
