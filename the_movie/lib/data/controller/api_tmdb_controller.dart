import 'package:the_movie/core/constants/strings_manager.dart';
import 'package:tmdb_api/tmdb_api.dart';

class ApiTmdbController {
  static final ApiTmdbController _instance = ApiTmdbController._internal();
  late final TMDB tmdb;

  factory ApiTmdbController() => _instance;

  ApiTmdbController._internal() {
    tmdb =
        TMDB(ApiKeys(StringsManager.apiKey, StringsManager.readAccessTokenv4));
  }

  static ApiTmdbController getInstance() => _instance;
}
