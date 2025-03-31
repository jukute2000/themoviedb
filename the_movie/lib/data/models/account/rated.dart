// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Rated {
  int value;

  Rated({
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
    };
  }

  factory Rated.fromMap(Map<String, dynamic> map) {
    return Rated(
      value: map['value'] as int,
    );
  }

  factory Rated.fromJson(String source) =>
      Rated.fromMap(json.decode(source) as Map<String, dynamic>);
}
