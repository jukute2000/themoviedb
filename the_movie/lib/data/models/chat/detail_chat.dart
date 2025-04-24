import 'package:the_movie/core/utils/safe_null.dart';


class DetailChat {
  String? idSend;
  String? messageId;
  String? message;
  String? time;

  DetailChat({
    required this.idSend,
    required this.messageId,
    required this.message,
    required this.time,
  });

  DateTime getDateHeader() {
    if (time != null) {
      DateTime date = DateTime.tryParse(time ?? "") ?? DateTime.now();
      return date;
    }
    return DateTime.now();
  }

  factory DetailChat.fromJson(Map<String, dynamic> json) {
    return DetailChat(
      idSend: SafeNull.checkString(json["id_send"]),
      messageId: SafeNull.checkString(json["message_id"]),
      message: SafeNull.checkString(json["message"]),
      time: SafeNull.checkString(json["time"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_send": idSend,
      "message_id": messageId,
      "message": message,
      "time": time,
    };
  }
}
