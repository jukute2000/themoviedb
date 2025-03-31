// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:the_movie/data/models/account/rated.dart';

class AccountStatus {
  int id;
  bool favorite;
  Rated rated;
  bool watchlist;

  AccountStatus({
    required this.id,
    required this.favorite,
    required this.rated,
    required this.watchlist,
  });


  factory AccountStatus.fromMap(Map<String, dynamic> map) {
    return AccountStatus(
      id: map['id'] as int ?? 0,
      favorite: map['favorite'] as bool ,
      rated: Rated.fromMap(map['rated'] as Map<String,dynamic>),
      watchlist: map['watchlist'] as bool,
    );
  }


  factory AccountStatus.fromJson(String source) => AccountStatus.fromMap(json.decode(source) as Map<String, dynamic>);
}
