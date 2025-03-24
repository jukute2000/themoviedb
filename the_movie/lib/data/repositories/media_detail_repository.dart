import 'package:the_movie/data/datasources/media_detail_datasoure.dart';

class MediaDetailRepository {
  final MediaDetailDatasoure _mediaDetailDatasoure = MediaDetailDatasoure();

  Future getMovieDetail(int id) async {
    return await _mediaDetailDatasoure.getMovieDetail(id);
  }

  Future getTVDetail(int id) async {
    return await _mediaDetailDatasoure.getTVDetail(id);
  }

  Future getMovieRecommendations(int id) async {
    return await _mediaDetailDatasoure.getMovieRecommendations(id);
  }

  Future getTvRecommendations(int id) async {
    return await _mediaDetailDatasoure.getTvRecommendations(id);
  }

  Future getCredits({required int id, required bool isMovie}) async {
    return await _mediaDetailDatasoure.getCredits(id: id, isMovie: isMovie);
  }

  Future getKeywords({required int id, required bool isMovie}) async {
    return await _mediaDetailDatasoure.getKeywords(id: id, isMovie: isMovie);
  }
}
