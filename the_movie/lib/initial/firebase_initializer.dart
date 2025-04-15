import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/widgets.dart';
import 'package:the_movie/initial/remote_confic.dart';

class FirebaseInitializer {
  static Future<void> devInitialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        //keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
        apiKey: "AIzaSyBEj7pgpSGF1XNy2n62KTj1T6gr-LykxY8",
        appId: "1:496892763559:android:3b0e17a3b205125865aa82",
        messagingSenderId: "496892763559",
        projectId: "tmdb-20cce",
      ),
    );
    // Kích hoạt Firebase Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    // Kích hoạt chế độ thu thập dữ liệu Crash khi chạy Debug
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    RemoteConfic.instance.initRemoteConfig();
  }

  static Future<void> prodInitialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        //keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
        apiKey: "AIzaSyBEj7pgpSGF1XNy2n62KTj1T6gr-LykxY8",
        appId: "1:496892763559:android:5e7721a9b35dbc5a65aa82",
        messagingSenderId: "496892763559",
        projectId: "tmdb-20cce",
      ),
    );
    // Kích hoạt Firebase Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    // Kích hoạt chế độ thu thập dữ liệu Crash khi chạy Debug
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    RemoteConfic.instance.initRemoteConfig();
  }
}
