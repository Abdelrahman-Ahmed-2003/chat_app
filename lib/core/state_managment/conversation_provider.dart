import 'dart:async';
import 'package:chat_app/core/model/chat_model.dart';
import 'package:chat_app/core/model/connection_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConversationProvider extends ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<ChatModel> chats = [];
  bool isLoading = false;
  bool findConnection = false;
  List<Map<String, dynamic>> messages = [];
  Map<String, dynamic>? sender;
  ConnectionModel? activeConnection;
  String? conversationId;

  StreamSubscription<dynamic>? _messageSubscription;

  // Fetch receiver's UUID using phone number
  Future<String?> fetchReceiverId(String receiverPhone) async {
    try {
      final response = await supabase
          .from('users')
          .select('id')
          .eq('phone_num', receiverPhone)
          .maybeSingle();

      if (response != null) {
        return response['id'] as String;
      }
    } catch (e) {
      debugPrint('Error fetching receiver ID: $e');
    }
    return null;
  }

  // Check for existing connection or chat
  Future<String?> findExistingConnection(String receiverPhone) async {
    if (sender == null) {
      await fetchSender();
    }
    findConnection = false;
    final receiverId = await fetchReceiverId(receiverPhone);
    if (receiverId == null) {
      debugPrint('Receiver not found for phone number: $receiverPhone');
      return null;
    }

    print(
        'Querying with sender_id: ${sender!['id']} and receiver_id: $receiverId');

    try {
      final response = await supabase
          .from('connection')
          .select('chat_id, recivers_id')
          .eq('sender_id', sender!['id']);
      // .eq('recivers_id->>id', receiverId) // JSON path query

      print('response issssssssssssssssssssssssssss');
      print(response);
      String chatId = '';
      if (response.isNotEmpty) {
        for (Map rec in response) {
          print(rec);
          if (rec['recivers_id'].length == 1 &&
              receiverId == rec['recivers_id'].first['id']) {
            chatId = rec['chat_id'];
            print('chat id in loop issssssssssssssss');
            findConnection = true;
            print(chatId);
            break;
          }
        }
        debugPrint('chat_id isssssssssssssssssssssssssssss');
        // debugPrint(response['chat_id']);
        findConnection = true;
        // return response['chat_id'] as String;
        return chatId;
      } else {
        debugPrint('not chat foundeddddddddddddddddddddddddddddddddddd');
      }
    } catch (e) {
      debugPrint('Error during query: $e');
    }
    return null;
  }

  // Create a new connection
  // Create a new connection with multiple receivers
  Future<String?> createConnection({
    required String receiverPhone,
    required String idMessage,
  }) async {
    if (sender == null) {
      await fetchSender();
    }

    final receiverId = await fetchReceiverId(receiverPhone);
    if (receiverId == null) {
      debugPrint('Cannot create connection. Receiver not found.');
      return null;
    }

    // Create chat record first
    final chatResponse = await supabase
        .from('chat')
        .insert({
          'id_message': idMessage,
          'name': '', // Customize chat name if needed
          'image': '', // Add an image if required
          'last_message': {}, // Empty initially
        })
        .select('id') // Ensure we get the chat ID
        .single();

    // Extract the chat ID from the response
    final chatId = chatResponse['id'];

    if (chatId == null) {
      debugPrint('Failed to create chat. No chat ID returned.');
      return null;
    }

    // Create connection record with valid chat_id
    try {
      await supabase.from('connection').insert({
        'sender_id': sender!['id'],
        'recivers_id': [
          {'id': receiverId}, // Add the receiver as part of the array
        ],
        'chat_id': chatId, // Use the correct chat_id here
        'unread_messages': 0, // Initialize unread messages to 0
      });

      return chatId; // Return the chat ID after successful creation
    } catch (e) {
      debugPrint('Error creating connection: $e');
      return null;
    }
  }



  //create chat and return id of chat
  



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

  // Fetch all chats for the user
  Future<void> fetchChats() async {
    try {
      isLoading = true;
      notifyListeners();

      if (sender == null) await fetchSender();

      final response = await supabase
          .from('connection')
          .select('*, chat(*)')
          .eq('sender_id', sender!['id']);

      print('response of fetch cahtsssssssssssssssssssssssss is:');
      print(response);
      if (response.isNotEmpty) {
        chats = response.map<ChatModel>((chatData) {
          debugPrint(
              'print some dataaaaaaaaaaaaaaaaaa in fetch chatssssssssss');
          debugPrint(chatData.toString());
          debugPrint(chatData['chat']['name'].toString());
          debugPrint(chatData['chat']['last_message'].toString());
          return ChatModel.fromJson(chatData['chat']);
        }).toList();
        debugPrint(
            'all fetched chatssssssssssssssssssssssssssssssss for sender');
        debugPrint(chats.toString());
      }
    } catch (e) {
      debugPrint('Error fetching chats: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> getMessageIdFromChatId(String chatId) async {
    try {
      final response = await supabase
          .from('chat')
          .select('id_message')
          .eq('id', chatId)
          .maybeSingle();

      if (response == null) {
        debugPrint('Error fetching id_message: ');
        return null;
      }

      final idMessage = response['id_message'] as String?;
      debugPrint('id_message issss : ' + response['id_message']);
      return idMessage;
    } catch (e) {
      debugPrint('Error getting id_message: $e');
      return null;
    }
  }

  // Start listening for new messages
  void listenToMessages(String chatId) async {
    // Cancel any existing subscriptions before starting a new one
    _messageSubscription?.cancel();

    // Step 1: Get id_message from chatId
    String? messageId = await getMessageIdFromChatId(chatId);
    if (messageId == null) {
      debugPrint('No id_message found for chatId: $chatId');
      return;
    }

    // Step 2: Start listening to messages for the given id_message
    _messageSubscription = supabase
        .from('conversations')
        .stream(primaryKey: ['id'])
        .eq('id', messageId)
        .listen((data) {
          if (data.isNotEmpty) {
            print('data in listen function issssssssssssssssssssssssssss');
            print(data.toString());
            messages =
                List<Map<String, dynamic>>.from(data.first['messages'] ?? []);
            notifyListeners();
          }
        });
  }

  // Send a message
  Future<void> sendMessage(String chatId, String content) async {
    if (content.trim().isEmpty) return;

    debugPrint('in send message functionnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
    final newMessage = {
      'type': 'string',
      'content': content,
      'time': DateTime.now().toIso8601String(),
    };
    String idMessage = '';

    try {
      if (!findConnection) {
        final responseIdMessage = await supabase
            .from('conversations')
            .insert({
              'messages': [newMessage], // Insert the message as a list
            })
            .select('id')
            .single();

        idMessage = responseIdMessage['id'];

        await createConnection(
          receiverPhone: chatId,
          idMessage: idMessage,
        );
      } else {
        final chatResponse = await supabase
            .from('chat')
            .select('id_message')
            .eq('id', chatId)
            .single();

        idMessage = chatResponse['id_message'];
      }

      // Retrieve the existing messages or initialize with an empty list
      final existingMessagesResponse = await supabase
          .from('conversations')
          .select('messages')
          .eq('id', idMessage)
          .single();

      final existingMessages =
          existingMessagesResponse['messages'] as List<dynamic>? ?? [];
      final updatedMessages = [...existingMessages, newMessage];

      final updateResponse = await supabase
          .from('conversations')
          .update({'messages': updatedMessages}).eq('id', idMessage);

      if (updateResponse.error != null) {
        debugPrint(
            'Error updating existing chat: ${updateResponse.error!.message}');
        throw updateResponse.error!;
      }

      debugPrint('Message added to existing chat.');

      // Add the new message to the local messages list after the conditions
      messages.add(newMessage);
      notifyListeners();
    } catch (e) {
      debugPrint('Error sending message: $e');
    }
  }

  // Dispose of listeners
  @override
  void dispose() {
    _messageSubscription?.cancel();
    super.dispose();
  }
}
