import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireHelper {
  static FireHelper fireHelper = FireHelper._();

  FireHelper._();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> singUp(
      {required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return "Failed";
    }
  }

  Future<String> singIn(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return "Failed";
    }
  }

  bool checkUser() {
    User? user = auth.currentUser;
    return user != null;
  }

  Future<void> signOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
  }

  Future<String> googleSignIn() async {
    GoogleSignInAccount? account = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? gAuth = await account?.authentication;

    var crd = GoogleAuthProvider.credential(accessToken: gAuth?.accessToken,idToken: gAuth?.idToken);

    try {
      await auth.signInWithCredential(crd);
      return "success";
    } catch (e) {
      return e.toString();
    }
  }
}
