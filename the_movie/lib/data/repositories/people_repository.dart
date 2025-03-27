import 'package:the_movie/data/controller/api_tmdb_controller.dart';
import 'package:the_movie/data/models/people/people_detail.dart';
import 'package:the_movie/data/models/search/search_people.dart';

import '../models/medias/media.dart';
import '../models/medias/movie.dart';
import '../models/medias/tv.dart';

abstract class PeopleRepository {
  Future<SearchPeople> getPeoplePopular({required int page});
  Future<PeopleDetail> getPeopleDetail({required int id});
  Future<List<Media>> getCredits({required int id});
}

class PeopleRepositoryImpl implements PeopleRepository {
  static final PeopleRepositoryImpl _instance =
      PeopleRepositoryImpl._internal();
  PeopleRepositoryImpl._internal();
  static PeopleRepositoryImpl get intance => _instance;

  @override
  Future<SearchPeople> getPeoplePopular({required int page}) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .people
        .getPopular(page: page) as Map<String, dynamic>;
    return SearchPeople.fromJson(result);
  }

  @override
  Future<PeopleDetail> getPeopleDetail({required int id}) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .people
        .getDetails(id) as Map<String, dynamic>;
    return PeopleDetail.fromJson(result);
  }

  Media _getMediaFromJson(Map<String, dynamic> json) {
    if (json['media_type'] == 'movie') {
      return Movie.fromJson(json);
    } else {
      return TiVi.fromJson(json);
    }
  }

  @override
  Future<List<Media>> getCredits({required int id}) async {
    Map<String, dynamic> result = await ApiTmdbController.getInstance()
        .tmdb
        .v3
        .people
        .getCombinedCredits(id) as Map<String, dynamic>;
    List results = result['cast'];
    return results.map((json) => _getMediaFromJson(json)).toList();
  }
}
