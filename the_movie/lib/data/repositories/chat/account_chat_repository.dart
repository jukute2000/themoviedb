import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_movie/data/controller/fire_auth_controller.dart';
import 'package:the_movie/data/controller/firebase_tmdb_controller.dart';
import 'package:the_movie/data/models/auth/firebase_auth_model.dart';
import '../../models/chat/auth.dart';

abstract class AccountChatRepository {
  Future<FirebaseAuthModel> signInAccount(
      String email, String password, String name);
  Future<FirebaseAuthModel> loginAccount(String email, String password);
  Future<bool> logoutAccount();
  Future<User?> refeshUser();
}

class AccountChatRepositoryImpl implements AccountChatRepository {
  static final AccountChatRepositoryImpl _instance =
      AccountChatRepositoryImpl._internal();
  AccountChatRepositoryImpl._internal();
  static AccountChatRepositoryImpl get instance => _instance;
  @override
  Future<FirebaseAuthModel> signInAccount(
      String email, String password, String name) async {
    try {
      await FireAuthController.getInstance()
          .auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = await refeshUser();
      await user!.updateProfile(displayName: name);
      user = await refeshUser();
      Authentication auth = Authentication.fromJson({
        "id": user!.uid,
        "name": user.displayName,
      });

      await FirebaseTmdbController.getInstance()
          .db
          .collection("listUser")
          .doc("list_user")
          .set({
        "list_users": FieldValue.arrayUnion([auth.toJson()])
      }, SetOptions(merge: true));
      return FirebaseAuthModel(
        result: true,
        error: '',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        return FirebaseAuthModel(
          result: false,
          error: "Weak Password",
        );
      } else if (e.code == "email-alrealy-in-use") {
        return FirebaseAuthModel(
          result: false,
          error: "Email alrealy exist Login Please !",
        );
      }
      return FirebaseAuthModel(
        result: false,
        error: e.code,
      );
    } catch (ex) {
      return FirebaseAuthModel(
        result: false,
        error: ex.toString(),
      );
    }
  }

  @override
  Future<FirebaseAuthModel> loginAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return FirebaseAuthModel(
        result: true,
        error: '',
      );
    } on FirebaseException catch (e) {
      if (e.code == "user-not-found") {
        return FirebaseAuthModel(
          result: false,
          error: "Email id dose not exist",
        );
      } else if (e.code == "wrong-password") {
        return FirebaseAuthModel(
          result: false,
          error: "Wrong password",
        );
      }
      return FirebaseAuthModel(
        result: false,
        error: e.code,
      );
    } catch (ex) {
      return FirebaseAuthModel(
        result: false,
        error: ex.toString(),
      );
    }
  }

  @override
  Future<bool> logoutAccount() async {
    try {
      await FireAuthController.getInstance().auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<User?> refeshUser() async {
    try {
      await FireAuthController.getInstance().auth.currentUser?.reload();
      User? user = FireAuthController.getInstance().auth.currentUser;
      return user;
    } catch (e) {
      return null;
    }
  }
}
