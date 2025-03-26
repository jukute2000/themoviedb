import 'package:tmdb_api/tmdb_api.dart';

class TMDBSingleton {
  static final TMDBSingleton _instance = TMDBSingleton._internal();

  late final TMDB tmdb;
  TMDBSingleton._internal() {
    tmdb = TMDB(
      ApiKeys(
        '720076a020957ba9c71639b58e065e7a',
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MjAwNzZhMDIwOTU3YmE5YzcxNjM5YjU4ZTA2NWU3YSIsIm5iZiI6MTc0MjI5MDg5OS45ODcsInN1YiI6IjY3ZDkzZmQzYmI0MzM5NTFhNzM2NWY5YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4AvnJMj9eRScLe9s-SWLD0YeqnnJDxyyQecErfnVDxo',
      ),
    );
  }

  static TMDBSingleton get instance => _instance;
}
