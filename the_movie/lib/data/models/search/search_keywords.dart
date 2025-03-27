import 'package:the_movie/core/utils/safe_null.dart';
import 'package:the_movie/data/models/keyword/keyword.dart';

class SearchKeywords {
  int? page;
  List<Keyword>? keywords;
  int? totalPages;
  int? totalResults;

  SearchKeywords(
      {required this.page,
      required this.keywords,
      required this.totalPages,
      required this.totalResults});

  factory SearchKeywords.formJson(Map<String, dynamic> json) => SearchKeywords(
        page: SafeNull.checkInt(json["page"]),
        keywords: json["results"] != null
            ? List<Keyword>.from(
                json["results"].map((x) => Keyword.fromJson(x)))
            : null,
        totalPages: SafeNull.checkInt(json["total_pages"]),
        totalResults: SafeNull.checkInt(json["total_results"]),
      );
}
