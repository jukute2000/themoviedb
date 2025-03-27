import 'package:the_movie/data/controller/api_tmdb_controller.dart';
import 'package:the_movie/data/models/search/search_collections.dart';
import 'package:the_movie/data/models/search/search_companies.dart';
import 'package:the_movie/data/models/search/search_keywords.dart';
import 'package:the_movie/data/models/search/search_movie.dart';
import 'package:the_movie/data/models/search/search_tv.dart';
import '../models/search/search_multi.dart';
import '../models/search/search_people.dart';

abstract class SearchRepository {
  Future<List<SearchMulti>> getSearchMutil(String query);
  Future<SearchMovie> getSearchMovies(String query, int page);
  Future<SearchTv> getSearchTv(String query, int page);
  Future<SearchPeople> getSearchPeople(String query, int page);
  Future<SearchKeywords> getSearchKeywords(String query, int page);
  Future<SearchCompanies> getSearchCompany(String query, int page);
  Future<SearchCollections> getSearchCollections(String query, int page);
}

class SearchRepositoryImpl implements SearchRepository {
  static final SearchRepositoryImpl _instance =
      SearchRepositoryImpl._internal();
  SearchRepositoryImpl._internal();
  static SearchRepositoryImpl get instance => _instance;

  @override
  Future<List<SearchMulti>> getSearchMutil(String query) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .search
        .queryMulti(query) as Map<String, dynamic>;
    List results = result["results"];
    return results.map((json) => SearchMulti.formJson(json)).toList();
  }

  @override
  Future<SearchMovie> getSearchMovies(String query, int page) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .search
        .queryMovies(query, page: page) as Map<String, dynamic>;
    return SearchMovie.fromJson(result);
  }

  @override
  Future<SearchTv> getSearchTv(String query, int page) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .search
        .queryTvShows(query, page: page) as Map<String, dynamic>;
    return SearchTv.fromJson(result);
  }

  @override
  Future<SearchPeople> getSearchPeople(String query, int page) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .search
        .queryPeople(query, page: page) as Map<String, dynamic>;
    return SearchPeople.fromJson(result);
  }

  @override
  Future<SearchKeywords> getSearchKeywords(String query, int page) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .search
        .queryKeywords(query, page: page) as Map<String, dynamic>;
    return SearchKeywords.formJson(result);
  }

  @override
  Future<SearchCompanies> getSearchCompany(String query, int page) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .search
        .queryCompanies(query, page: page) as Map<String, dynamic>;
    return SearchCompanies.fromJson(result);
  }

  @override
  Future<SearchCollections> getSearchCollections(String query, int page) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .search
        .queryCollections(query, page: page) as Map<String, dynamic>;
    return SearchCollections.fromJson(result);
  }
}
