import 'package:the_movie/data/controller/api_tmdb_controller.dart';
import 'package:the_movie/data/models/people/people_detail.dart';
import 'package:the_movie/data/models/search/search_people.dart';
import '../models/credits/combined_credit.dart/combined_credit.dart';
import '../models/credits/external.dart';
import '../models/medias/movie.dart';

abstract class PeopleRepository {
  Future<SearchPeople?> getPeoplePopular({required int page});
  Future<PeopleDetail?> getPeopleDetail({required int id});
  Future<CombinedCredit?> getAllCredits({required int id});
  Future<External?> getExternal({required int id});
  Future<List<Movie>?> getKnowFor({required int id});
}

class PeopleRepositoryImpl implements PeopleRepository {
  static final PeopleRepositoryImpl _instance =
      PeopleRepositoryImpl._internal();
  PeopleRepositoryImpl._internal();
  static PeopleRepositoryImpl get intance => _instance;

  @override
  Future<SearchPeople?> getPeoplePopular({required int page}) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .people
        .getPopular(page: page) as Map<String, dynamic>;
    return result.isNotEmpty ? SearchPeople.fromJson(result) : null;
  }

  @override
  Future<PeopleDetail?> getPeopleDetail({required int id}) async {
    try {
      Map<String, dynamic> result = await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .people
          .getDetails(id) as Map<String, dynamic>;

      return result.isNotEmpty ? PeopleDetail.fromJson(result) : null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<CombinedCredit?> getAllCredits({required int id}) async {
    try {
      Map<String, dynamic> result = await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .people
          .getCombinedCredits(id) as Map<String, dynamic>;
      return result.isNotEmpty ? CombinedCredit.fromJson(result) : null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<External?> getExternal({required int id}) async {
    try {
      Map<String, dynamic> result = await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .people
          .getExternalIds(id) as Map<String, dynamic>;
      return result.isNotEmpty ? External.fromJson(result) : null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Movie>?> getKnowFor({required int id}) async {
    try {
      Map<String, dynamic> result = await ApiTmdbController.getInstance()
          .tmdb
          .v3
          .people
          .getMovieCredits(id) as Map<String, dynamic>;
      List results = result["cast"];
      return result.isNotEmpty
          ? results.map((json) => Movie.fromJson(json)).toList()
          : null;
    } catch (e) {
      return null;
    }
  }
}
