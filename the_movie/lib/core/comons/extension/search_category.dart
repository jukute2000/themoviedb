import 'package:easy_localization/easy_localization.dart';

import '../../constants/strings_manager.dart';

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
        return StringsManager.tvShows.tr();
      case SearchCategory.movie:
        return StringsManager.movies.tr();
      case SearchCategory.people:
        return StringsManager.people.tr();
      case SearchCategory.collections:
        return StringsManager.collections.tr();
      case SearchCategory.keywords:
        return StringsManager.keywords.tr();
      case SearchCategory.companies:
        return StringsManager.companies.tr();
    }
  }
}
