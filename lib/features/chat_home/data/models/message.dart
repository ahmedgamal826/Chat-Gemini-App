// class Message {
//   String messageId;
//   String chatId;
//   Role role;
//   StringBuffer message;
//   List<String> imagesUrls;
//   DateTime timeSent;

//   // constructor
//   Message({
//     required this.messageId,
//     required this.chatId,
//     required this.role,
//     required this.message,
//     required this.imagesUrls,
//     required this.timeSent,
//   });

//   // toMap
//   Map<String, dynamic> toMap() {
//     return {
//       'messageId': messageId,
//       'chatId': chatId,
//       'role': role.index,
//       'message': message.toString(),
//       'imagesUrls': imagesUrls,
//       'timeSent': timeSent.toIso8601String(),
//     };
//   }

//   // from map
//   factory Message.fromMap(Map<String, dynamic> map) {
//     return Message(
//       messageId: map['messageId'],
//       chatId: map['chatId'],
//       role: Role.values[map['role']],
//       message: StringBuffer(map['message']),
//       imagesUrls: List<String>.from(map['imagesUrls']),
//       timeSent: DateTime.parse(map['timeSent']),
//     );
//   }

//   // copyWith
//   Message copyWith({
//     String? messageId,
//     String? chatId,
//     Role? role,
//     StringBuffer? message,
//     List<String>? imagesUrls,
//     DateTime? timeSent,
//   }) {
//     return Message(
//       messageId: messageId ?? this.messageId,
//       chatId: chatId ?? this.chatId,
//       role: role ?? this.role,
//       message: message ?? this.message,
//       imagesUrls: imagesUrls ?? this.imagesUrls,
//       timeSent: timeSent ?? this.timeSent,
//     );
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is Message && other.messageId == messageId;
//   }

//   @override
//   int get hashCode {
//     return messageId.hashCode;
//   }
// }

// enum Role {
//   user,
//   assistant, // gemini
// }

class Message {
  String messageId;
  String chatId;
  Role role;
  StringBuffer message;
  List<String> imagesUrls;
  String timeSent; // تغيير من DateTime إلى String

  // constructor
  Message({
    required this.messageId,
    required this.chatId,
    required this.role,
    required this.message,
    required this.imagesUrls,
    required this.timeSent, // تعديل لتقبل String بدل DateTime
  });

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'chatId': chatId,
      'role': role.index,
      'message': message.toString(),
      'imagesUrls': imagesUrls,
      'timeSent': timeSent, // تخزين الوقت كنص
    };
  }

  // fromMap
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      messageId: map['messageId'],
      chatId: map['chatId'],
      role: Role.values[map['role']],
      message: StringBuffer(map['message']),
      imagesUrls: List<String>.from(map['imagesUrls']),
      timeSent: map['timeSent'], // استرجاع الوقت كنص
    );
  }

  // copyWith
  Message copyWith({
    String? messageId,
    String? chatId,
    Role? role,
    StringBuffer? message,
    List<String>? imagesUrls,
    String? timeSent, // تغيير هنا ليكون من النوع String
  }) {
    return Message(
      messageId: messageId ?? this.messageId,
      chatId: chatId ?? this.chatId,
      role: role ?? this.role,
      message: message ?? this.message,
      imagesUrls: imagesUrls ?? this.imagesUrls,
      timeSent: timeSent ?? this.timeSent, // تغيير هنا ليكون من النوع String
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message && other.messageId == messageId;
  }

  @override
  int get hashCode {
    return messageId.hashCode;
  }
}

enum Role {
  user,
  assistant, // gemini
}
