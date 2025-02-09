class ChatModel {
  String chatId;
  int id;
  String name;
  String? image;
  LastMessage lastMessage;
  String conversationId;
  bool isGroup;

  ChatModel({
    required this.chatId,
    required this.id,
    required this.name,
    this.image,
    required this.lastMessage,
    required this.conversationId,
    required this.isGroup,
  });

  // Factory constructor to create a ChatModel from a JSON map
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    print('in chat model from jsonnnnnnnnnnnnnnnnnnnnnnnnn');
    print(json.toString());
    var chatModel = ChatModel(
      isGroup: json['is_group'] ?? false,
      chatId: json['chat_id'],
      id: json['id'],
      name: (json['name']) ?? '',
      image: json['image'] ?? '',
      lastMessage: LastMessage.fromJson(json['last_message']),
      conversationId: json['conversation_id'],
    );
    print('chat modeeeeeeellllllllllllll is');
    print(chatModel);
    return chatModel;
  }

  // Method to convert a ChatModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'lastMessage': lastMessage.toJson(),
      'conversationId': conversationId,
    };
  }

  @override
  String toString() {
    return 'ChatModel(id: $id, name: $name, image: $image, lastMessage: $lastMessage, conversationId: $conversationId)';
  }
}

class LastMessage {
  String messageType;
  String content;
  DateTime time;

  LastMessage({
    required this.messageType,
    required this.content,
    required this.time,
  });

  // Factory constructor to create a LastMessage from a JSON map
  factory LastMessage.fromJson(Map<String, dynamic> json) {
    var lastMessage = LastMessage(
      messageType: json['message_type'],
      content: json['message'],
      time: DateTime.parse(json['createdAt']),
    );
    print('last messageeeeeeeeeeeeeeeeeeeeeee');
    print(lastMessage.toString());
    return lastMessage;
  }

  // Method to convert a LastMessage instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'messageType': messageType,
      'content': content,
      'time': time.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'LastMessage(messageType: $messageType, content: $content, time: $time)';
  }
}
