import 'package:the_movie/data/models/company/company.dart';

class SearchCompanies {
  int page;
  List<Company> companies;
  int totalPages;
  int totalResults;

  SearchCompanies({
    required this.page,
    required this.companies,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchCompanies.fromJson(Map<String, dynamic> json) =>
      SearchCompanies(
        page: json["page"],
        companies:
            List<Company>.from(json["results"].map((x) => Company.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
