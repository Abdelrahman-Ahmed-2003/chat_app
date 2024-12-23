class ChatModel {
  String id;
  String name;
  String? image;
  LastMessage lastMessage;
  String? id_message;

  ChatModel({
    required this.id,
    required this.name,
    this.image,
    required this.lastMessage,
    this.id_message,
  });

  // Factory constructor to create a ChatModel from a JSON map
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] as String,
      name: (json['name'] as String?) ?? "",
      image: json['image'] as String?,
      lastMessage: LastMessage.fromJson(json['last_message']),
      id_message: json['id_message'] as String,
    );
  }

  // Method to convert a ChatModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'lastMessage': lastMessage.toJson(),
      'id_message': id_message,
    };
  }

  @override
  String toString() {
    return 'ChatModel(id: $id, name: $name, image: $image, lastMessage: $lastMessage, id_message: $id_message)';
  }
}

class LastMessage {
  String? messageType;
  String? content;
  DateTime? time;

  LastMessage({
    required this.messageType,
    required this.content,
    required this.time,
  });

  // Factory constructor to create a LastMessage from a JSON map
  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      messageType: json['messageType'],
      content: json['content'],
      time: json['time'] == null ? null:DateTime.parse(json['time']),
    );
  }

  // Method to convert a LastMessage instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'messageType': messageType,
      'content': content,
      'time': time?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'LastMessage(messageType: $messageType, content: $content, time: $time)';
  }
}