import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_movie/data/controller/fire_auth_controller.dart';

abstract class AccountChatRepository {
  Future<String> signInAccount(String email, String password);
  Future<String> loginAccount(String email, String password);
  Future<bool> logoutAccount();
  Future<User?> refeshUser();
}

class AccountChatRepositoryImpl implements AccountChatRepository {
  @override
  Future<String> signInAccount(String email, String password) async {
    try {
      await FireAuthController.getInstance()
          .auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
      return "Account Created";
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        return "Weak Password";
      } else if (e.code == "email-alrealy-in-use") {
        return "Email alrealy exist Login Please !";
      }
      return e.code;
    } catch (ex) {
      return "$ex";
    }
  }

  @override
  Future<String> loginAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Login account";
    } on FirebaseException catch (e) {
      if (e.code == "user-not-found") {
        return "Email id dose not exist";
      } else if (e.code == "wrong-password") {
        return "Wrong password";
      }
      return e.code;
    } catch (ex) {
      return "$ex";
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
