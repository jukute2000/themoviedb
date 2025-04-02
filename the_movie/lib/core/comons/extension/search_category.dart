import 'package:easy_localization/easy_localization.dart';
import 'package:the_movie/core/configs/assets/app_strings.dart';

enum SearchCategory {
  tv,
  movie,
  people,
  collections,
  keywords,
  companies,
}

extension SearchCategoryExtension on SearchCategory {
  String get name {
    switch (this) {
      case SearchCategory.tv:
        return "tv";
      case SearchCategory.movie:
        return "movie";
      case SearchCategory.people:
        return "people";
      case SearchCategory.collections:
        return "collections";
      case SearchCategory.keywords:
        return "keywords";
      case SearchCategory.companies:
        return "companies";
    }
  }

  String get localizedName {
    switch (this) {
      case SearchCategory.tv:
        return AppStrings.tvShows.tr();
      case SearchCategory.movie:
        return AppStrings.movies.tr();
      case SearchCategory.people:
        return AppStrings.people.tr();
      case SearchCategory.collections:
        return AppStrings.collections.tr();
      case SearchCategory.keywords:
        return AppStrings.keywords.tr();
      case SearchCategory.companies:
        return AppStrings.companies.tr();
    }
  }
}
