import 'package:the_movie/core/utils/safe_null.dart';

class ChatRoom {
  String? chatId;
  String? createdAt;
  List<String>? usersId;

  ChatRoom({
    required this.chatId,
    required this.createdAt,
    required this.usersId,
  });

  factory ChatRoom.formJson(Map<String, dynamic> json) {
    return ChatRoom(
      chatId: SafeNull.checkString(json["chat_id"]),
      createdAt: SafeNull.checkString(json["created_at"]),
      usersId:
          json["users_id"] != null ? List<String>.from(json["users_id"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "chat_id": chatId,
      "created_at": createdAt,
      "users_id": usersId,
    };
  }
}
