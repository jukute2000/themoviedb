import 'package:flutter/cupertino.dart';
import 'package:the_movie/initial/firebase_initializer.dart';

import 'flavor/env.dart';
import 'flavor/flavor_config.dart';
import 'main.dart';

void main() async {
  FlavorConfig(
      flavor: Flavor.dev, values: FlavorValues.fromJson(env[Flavor.prod]!));
  await FirebaseInitializer.prodInitialize();
  runApp(const MyApp());
}
