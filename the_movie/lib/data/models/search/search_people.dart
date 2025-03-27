import 'package:the_movie/core/utils/safe_null.dart';
import 'package:the_movie/data/models/people/people.dart';

class SearchPeople {
  int? page;
  List<People>? peoples;
  int? totalPages;
  int? totalResults;

  SearchPeople(
      {required this.page,
      required this.peoples,
      required this.totalPages,
      required this.totalResults});

  factory SearchPeople.fromJson(Map<String, dynamic> json) => SearchPeople(
        page: SafeNull.checkInt(json["page"]),
        peoples: json["results"] != null
            ? List<People>.from(json["results"].map((x) => People.fromJson(x)))
            : null,
        totalPages: SafeNull.checkInt(json["total_pages"]),
        totalResults: SafeNull.checkInt(json["total_results"]),
      );
}
