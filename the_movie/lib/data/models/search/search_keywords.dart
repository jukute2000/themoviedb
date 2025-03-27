import 'package:the_movie/data/models/keyword/keyword.dart';

class SearchKeywords {
  int page;
  List<Keyword> keywords;
  int totalPages;
  int totalResults;

  SearchKeywords(
      {required this.page,
      required this.keywords,
      required this.totalPages,
      required this.totalResults});

  factory SearchKeywords.formJson(Map<String, dynamic> json) => SearchKeywords(
        page: json["page"],
        keywords:
            List<Keyword>.from(json["results"].map((x) => Keyword.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
