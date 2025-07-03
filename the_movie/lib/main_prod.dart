import 'package:flutter/cupertino.dart';
import 'package:the_movie/initial/firebase_initializer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'flavor/env.dart';
import 'flavor/flavor_config.dart';
import 'main.dart';

void main() async {
  FlavorConfig(
      flavor: Flavor.dev, values: FlavorValues.fromJson(env[Flavor.prod]!));
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInitializer.devInitialize();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('vi'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp()));
}
