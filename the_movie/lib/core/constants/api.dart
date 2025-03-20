
import 'package:the_movie/data/models/medias/media.dart';
import 'package:the_movie/data/models/medias/movie.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../data/models/medias/tv.dart';


class Api {
  static const apiKey = '720076a020957ba9c71639b58e065e7a';
  static const accessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MjAwNzZhMDIwOTU3YmE5YzcxNjM5YjU4ZTA2NWU3YSIsIm5iZiI6MTc0MjI5MDg5OS45ODcsInN1YiI6IjY3ZDkzZmQzYmI0MzM5NTFhNzM2NWY5YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4AvnJMj9eRScLe9s-SWLD0YeqnnJDxyyQecErfnVDxo';

  final tmdb = TMDB(ApiKeys(apiKey, accessToken));

  Media getMediaFromJson(Map<String, dynamic> json) {
    if (json['media_type'] == 'movie') {
      return Movie.fromJson(json);
    } else {
      return TiVi.fromJson(json);
    }
  }

  Future<List<Media>> getMoviePopular() async {
    Map result = await tmdb.v3.trending.getTrending();
    List results = result['results'];
    return results.map((json) => getMediaFromJson(json)).toList();
  }
}