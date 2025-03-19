import 'package:flutter/cupertino.dart';
import 'package:the_movie/flavor/flavor_config.dart';

import 'flavor/env.dart';
import 'main.dart';

void main() {
  FlavorConfig(
      flavor: Flavor.dev, values: FlavorValues.fromJson(env[Flavor.dev]!));
  runApp(const MyApp());
}
