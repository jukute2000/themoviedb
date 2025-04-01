import 'package:the_movie/data/models/account/rated.dart';

class AccountStatus {
  final int id;
  final bool favorite;
  final Rated? rated;
  final bool watchlist;

  AccountStatus({
    required this.id,
    required this.favorite,
    required this.rated,
    required this.watchlist,
  });

  factory AccountStatus.fromJson(Map<String, dynamic> json) {
    return AccountStatus(
      id: json['id'] as int,
      favorite: json['favorite'] as bool,
      rated: json['rated'] is bool ? null : Rated.fromJson(json['rated']),
      watchlist: json['watchlist'] as bool,
    );
  }

  // Thêm phương thức để kiểm tra xem có rating hay không
  bool get hasRating => rated != null;

  // Thêm phương thức để lấy giá trị rating nếu có
  double? get ratingValue => rated?.value;

  String roundVoteAverage() {
    return "${(ratingValue! * 10).round()}%";
  }
}
