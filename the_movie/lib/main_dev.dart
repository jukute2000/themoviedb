import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:the_movie/flavor/env.dart';
import 'package:the_movie/flavor/flavor_config.dart';
import 'package:the_movie/initial/firebase_initializer.dart';
import 'package:the_movie/main.dart';

void main() async {
  FlavorConfig(
      flavor: Flavor.dev, values: FlavorValues.fromJson(env[Flavor.dev]!));
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInitializer.devInitialize();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('vi'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp()));
}
