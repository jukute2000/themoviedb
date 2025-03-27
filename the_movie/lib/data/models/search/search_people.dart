import 'package:the_movie/data/models/people/people.dart';

class SearchPeople {
  int page;
  List<People> peoples;
  int totalPages;
  int totalResults;

  SearchPeople({
    required this.page,
    required this.peoples,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchPeople.fromJson(Map<String, dynamic> json) => SearchPeople(
    page: json["page"] ?? 1,
    peoples: (json["results"] as List?)
        ?.map((x) => People.fromJson(x ?? {}))
        .toList() ??
        [],
    totalPages: json["total_pages"] ?? 1,
    totalResults: json["total_results"] ?? 0,
  );
}