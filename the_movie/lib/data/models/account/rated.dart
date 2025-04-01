class Rated {
  final double value;

  Rated({required this.value});

  factory Rated.fromJson(Map<String, dynamic> json) {
    return Rated(
      value: (json['value'] as num).toDouble(),
    );
  }
}
