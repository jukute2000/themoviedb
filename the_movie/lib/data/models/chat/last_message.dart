import 'package:firebase_auth/firebase_auth.dart';

class LastMessage {
  String? message;
  List<Map<String, dynamic>>? seen;

  LastMessage({
    required this.message,
    required this.seen,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      message: json["message"],
      seen: json["seen"] != null
          ? List<Map<String, dynamic>>.from(json["seen"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "seen": seen,
    };
  }

  int currentUserSeen() {
    int currentUserSeen = seen?.firstWhere(
        (e) => e["id"] == FirebaseAuth.instance.currentUser!.uid)["unseen"];
    return currentUserSeen;
  }
}
