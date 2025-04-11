class Session {
  final bool success;
  final String sessionId;

  Session({
    required this.success,
    required this.sessionId,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      success: (json['success'] ?? false) as bool,
      sessionId: (json['session_id'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'session_id': sessionId,
    };
  }
}
