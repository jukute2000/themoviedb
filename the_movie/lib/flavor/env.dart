import 'package:the_movie/flavor/flavor_config.dart';

Map<Flavor, Map<String, dynamic>> env = {
  Flavor.dev: <String, dynamic> {
    'baseUrl': 'https://api.themoviedb.org/3/',
  },
  Flavor.prod: <String, dynamic> {
    'baseUrl': 'https://api.themoviedb.org/3/',
  },
};