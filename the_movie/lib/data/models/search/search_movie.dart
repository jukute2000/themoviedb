import 'package:the_movie/core/utils/safe_null.dart';
import '../medias/movie.dart';

class SearchMovie {
  int? page;
  List<Movie>? results;
  int? totalPages;
  int? totalResults;

  SearchMovie({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchMovie.fromJson(Map<String, dynamic> json) => SearchMovie(
        page: SafeNull.checkInt(json["page"]),
        results: json["results"] != null
            ? List<Movie>.from(json["results"].map((x) => Movie.fromJson(x)))
            : null,
        totalPages: SafeNull.checkInt(json["total_pages"]),
        totalResults: SafeNull.checkInt(json["total_results"]),
      );
}
