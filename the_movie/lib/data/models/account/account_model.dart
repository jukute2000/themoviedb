class AccountModel {
  final Map<String, Map<String, dynamic>> avatar;
  final int id;
  final String iso6391;
  final String iso31661;
  final String name;
  final bool includeAdult;
  final String username;

  AccountModel({
    required this.avatar,
    required this.id,
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.includeAdult,
    required this.username,
  });

  // Factory constructor để tạo đối tượng từ JSON (nếu cần)
  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      avatar: Map<String, Map<String, dynamic>>.from(json['avatar'] ?? {}),
      id: json['id'] ?? 0,
      iso6391: json['iso_639_1'] ?? '',
      iso31661: json['iso_3166_1'] ?? '',
      name: json['name'] ?? '',
      includeAdult: json['include_adult'] ?? false,
      username: json['username'] ?? '',
    );
  }
}
