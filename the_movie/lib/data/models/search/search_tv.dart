import 'package:the_movie/data/models/medias/tv.dart';

class SearchTv {
  int page;
  List<TiVi> results;
  int totalPages;
  int totalResults;

  SearchTv({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchTv.fromJson(Map<String, dynamic> json) => SearchTv(
        page: json["page"],
        results: List<TiVi>.from(json["results"].map((x) => TiVi.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
