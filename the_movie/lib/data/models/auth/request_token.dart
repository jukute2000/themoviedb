class RequestToken {
  final bool success;
  final String expiresAt;
  final String requestToken;

  RequestToken({
    required this.success,
    required this.expiresAt,
    required this.requestToken,
  });

  factory RequestToken.fromJson(Map<String, dynamic> json) {
    return RequestToken(
      success: (json['success'] ?? false) as bool,
      expiresAt: (json['expires_at'] ?? '') as String,
      requestToken: (json['request_token'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'expires_at': expiresAt,
      'request_token': requestToken,
    };
  }
}
