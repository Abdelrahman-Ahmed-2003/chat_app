class ConnectionModel {
  String id;
  String sender_id;
  String chad_id;
  int unread_messages;
  ReciversId recivers_id;

  ConnectionModel({
    required this.id,
    required this.sender_id,
    required this.chad_id,
    required this.recivers_id,
    required this.unread_messages,
  });

  // Factory constructor to create a ConnectionModel from a JSON map
  factory ConnectionModel.fromJson(Map<String, dynamic> json) {
    return ConnectionModel(
      id: json['id'] as String,
      sender_id: json['sender_id'] as String,
      chad_id: json['chad_id'] as String,
      unread_messages: json['unread_messages'] as int,
      recivers_id:
          ReciversId.fromJson(json['recivers_id'] as Map<String, dynamic>),
    );
  }

  // Method to convert a ConnectionModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_id': sender_id,
      'chad_id': chad_id,
      'unread_messages': unread_messages,
      'recivers_id': recivers_id.toJson(),
    };
  }

  // Method to return a string representation of the ConnectionModel
  @override
  String toString() {
    return 'ConnectionModel(id: $id, sender_id: $sender_id, chad_id: $chad_id, unread_messages: $unread_messages, recivers_id: $recivers_id)';
  }
}

// Assuming ReciversId is another class with its own fromJson and toJson methods
class ReciversId {
  List<String> recivers;

  // Constructor to initialize the recivers list
  ReciversId({List<String>? recivers}) : recivers = recivers ?? [];

  // Factory constructor to create a ReciversId from a JSON map
  factory ReciversId.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw ArgumentError('JSON map cannot be null');
    }
    if (json['recivers'] is! List) {
      throw ArgumentError('Expected a List for recivers');
    }
    return ReciversId(
      recivers: List<String>.from(json['recivers'] ?? []),
    );
  }

  // Method to convert a ReciversId instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'recivers': recivers,
    };
  }

  @override
  String toString() {
    return 'ReciversId(recivers: $recivers)';
  }
}