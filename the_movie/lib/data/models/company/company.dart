class Company {
  int id;
  String? logoPath;
  String name;
  String? originCountry;

  Company(
      {required this.id,
      required this.name,
      required this.logoPath,
      required this.originCountry});

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );
}
