import 'package:the_movie/core/utils/safe_null.dart';
import 'package:the_movie/data/models/company/company.dart';

class SearchCompanies {
  int? page;
  List<Company>? companies;
  int? totalPages;
  int? totalResults;

  SearchCompanies({
    required this.page,
    required this.companies,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchCompanies.fromJson(Map<String, dynamic> json) =>
      SearchCompanies(
        page: SafeNull.checkInt(json["page"]),
        companies: json["results"] != null
            ? List<Company>.from(
                json["results"].map((x) => Company.fromJson(x)))
            : null,
        totalPages: SafeNull.checkInt(json["total_pages"]),
        totalResults: SafeNull.checkInt(json["total_results"]),
      );
}
