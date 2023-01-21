import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthUtil {
  static Future<String?> googleSignIn() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final gAccount = await googleSignIn.signIn();

    if (gAccount != null) {
      final authentication = await gAccount.authentication;
      final credentials = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

      try {
        final userCred = await auth.signInWithCredential(credentials);
        final user = userCred.user;
        return await user!.getIdToken(true);
      } on FirebaseAuthException catch (e) {
        debugPrint('Error in Auth: ${e.code}');
      }
    }
    return null;
  }
}
