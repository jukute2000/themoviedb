import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

class FirebaseInitializer {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        //keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
        apiKey: "AIzaSyBEj7pgpSGF1XNy2n62KTj1T6gr-LykxY8",
        appId: "1:496892763559:android:c48eb85aad0a45e665aa82",
        messagingSenderId: "496892763559",
        projectId: "tmdb-20cce",
      ),
    );
  }
}
