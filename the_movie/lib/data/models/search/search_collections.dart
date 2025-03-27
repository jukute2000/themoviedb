import 'package:the_movie/data/models/collection/collection.dart';

class SearchCollections {
  int page;
  List<Collection> collections;
  int totalPages;
  int totalResults;

  SearchCollections({
    required this.page,
    required this.collections,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchCollections.fromJson(Map<String, dynamic> json) =>
      SearchCollections(
        page: json["page"],
        collections: List<Collection>.from(
            json["results"].map((x) => Collection.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
