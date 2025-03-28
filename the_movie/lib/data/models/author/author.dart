import 'package:the_movie/core/utils/safe_null.dart';
import 'package:the_movie/data/models/author/author_detail.dart';

class Author {
  String? author;
  AuthorDetail? authorDetails;
  String? content;
  DateTime? createdAt;
  String? id;
  DateTime? updatedAt;
  String? url;

  Author({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.url,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        author: SafeNull.checkString(json["author"]),
        authorDetails: AuthorDetail.fromJson(json["author_details"]),
        content: SafeNull.checkString(json["content"]),
        createdAt: SafeNull.checkDateTime(json["created_at"]),
        id: SafeNull.checkString(json["id"]),
        updatedAt: SafeNull.checkDateTime(json["updated_at"]),
        url: SafeNull.checkString(json["url"]),
      );
}

class Review {
  int? id;
  int? page;
  List<Author> author;
  int? totalPages;
  int? totalResults;

  Review({
    required this.id,
    required this.page,
    required this.author,
    required this.totalPages,
    required this.totalResults,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"] is int
            ? json["id"]
            : json["id"] is String
                ? int.parse(json["id"])
                : null,
        page: json["page"] is int
            ? json["page"]
            : json["page"] is String
                ? int.parse(json["page"])
                : null,
        author:
            List<Author>.from(json["results"].map((x) => Author.fromJson(x))),
        totalPages: json["total_pages"] is int
            ? json["total_pages"]
            : json["total_pages"] is String
                ? int.parse(json["total_pages"])
                : null,
        totalResults: json["total_results"] is int
            ? json["total_results"]
            : json["total_results"] is String
                ? int.parse(json["total_results"])
                : null,
      );
}
