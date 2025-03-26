import 'package:the_movie/core/configs/assets/app_strings.dart';
import 'package:tmdb_api/tmdb_api.dart';

class ApiTmdbController {
  static final ApiTmdbController _instance = ApiTmdbController._internal();
  late final TMDB tmdb;

  factory ApiTmdbController() => _instance;

  ApiTmdbController._internal() {
    tmdb =
        TMDB(ApiKeys(AppStrings.apiKey, AppStrings.readAccessTokenv4));
  }

  static ApiTmdbController getInstance() => _instance;
}
