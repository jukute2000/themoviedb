import 'package:firebase_auth/firebase_auth.dart';

class FireAuthController {
  static final FireAuthController _instance = FireAuthController._internal();

  factory FireAuthController() => _instance;
  late final FirebaseAuth auth;
  FireAuthController._internal() {
    auth = FirebaseAuth.instance;
  }

  static FireAuthController getInstance() => _instance;
}
