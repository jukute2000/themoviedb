import 'package:flutter/cupertino.dart';

import 'flavor/env.dart';
import 'flavor/flavor_config.dart';
import 'main.dart';


void main() {
  FlavorConfig(
      flavor: Flavor.dev, values: FlavorValues.fromJson(env[Flavor.prod]!));
  runApp( const MyApp());
}
