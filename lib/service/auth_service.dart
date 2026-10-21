import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> register(String email, String password) async {
    try {
      var result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      var result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> googleAuth() async {
    try {
      GoogleSignInAccount? accUser = await GoogleSignIn().signIn();
      if (accUser == null) return null;
      GoogleSignInAuthentication gAuth = await accUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: gAuth.idToken,
        accessToken: gAuth.accessToken,
      );
      var result = await auth.signInWithCredential(credential);
      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  User? currentUser() {
    return auth.currentUser;
  }
}
