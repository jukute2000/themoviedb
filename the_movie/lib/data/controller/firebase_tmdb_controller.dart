import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTmdbController {
  static final FirebaseTmdbController _instance =
      FirebaseTmdbController._internal();

  factory FirebaseTmdbController() => _instance;

  late final FirebaseFirestore db;

  FirebaseTmdbController._internal() {
    db = FirebaseFirestore.instance;
  }

  static FirebaseTmdbController getInstance() => _instance;
}
