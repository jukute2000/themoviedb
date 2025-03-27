import 'package:the_movie/core/utils/safe_null.dart';
import 'package:the_movie/data/models/collection/collection.dart';

class SearchCollections {
  int? page;
  List<Collection>? collections;
  int? totalPages;
  int? totalResults;

  SearchCollections({
    required this.page,
    required this.collections,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchCollections.fromJson(Map<String, dynamic> json) =>
      SearchCollections(
        page: SafeNull.checkInt(json["page"]),
        collections: json["results"] != null
            ? List<Collection>.from(
                json["results"].map((x) => Collection.fromJson(x)))
            : null,
        totalPages: SafeNull.checkInt(json["total_pages"]),
        totalResults: SafeNull.checkInt(json["total_results"]),
      );
}
