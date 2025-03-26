import 'package:the_movie/data/models/people/people.dart';

class SearchPeople {
  int page;
  List<People> peoples;
  int totalPages;
  int totalResults;

  SearchPeople(
      {required this.page,
      required this.peoples,
      required this.totalPages,
      required this.totalResults});

  factory SearchPeople.fromJson(Map<String, dynamic> json) => SearchPeople(
        page: json["page"],
        peoples:
            List<People>.from(json["results"].map((x) => People.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
