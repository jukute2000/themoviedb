import 'package:the_movie/core/utils/safe_null.dart';
import 'package:the_movie/data/models/medias/tv.dart';

class SearchTv {
  int? page;
  List<TiVi>? results;
  int? totalPages;
  int? totalResults;

  SearchTv({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchTv.fromJson(Map<String, dynamic> json) => SearchTv(
        page: SafeNull.checkInt(json["page"]),
        results: json["results"] != null
            ? List<TiVi>.from(json["results"].map((x) => TiVi.fromJson(x)))
            : [],
        totalPages: SafeNull.checkInt(json["total_pages"]),
        totalResults: SafeNull.checkInt(json["total_results"]),
      );
}
