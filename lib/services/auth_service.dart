import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final User _user;

  bool userIsLogged() => _auth.currentUser != null;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User get user => _user;

  Future<void> createUser(
    final String email,
    final String password,
    final VoidCallback onCompleteCallback,
    final Function(String errorCode) onErrorCallback,
  ) async {
    try {
      final res = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = res.user!;
      notifyListeners();
      onCompleteCallback();
    } on FirebaseAuthException catch (e) {
      String code = e.code.replaceAll('-', ' ');
      code = code[0].toUpperCase() + code.substring(1);
      onErrorCallback(code);
    }
  }

  Future<void> login(
    final String email,
    final String password,
    final VoidCallback onCompleteCallback,
    final Function(String errorCode) onErrorCallback,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user!;
      print('logged');
      notifyListeners();
      onCompleteCallback();
    } on FirebaseAuthException catch (e) {
      String code = e.code.replaceAll('-', ' ');
      code = code[0].toUpperCase() + code.substring(1);
      onErrorCallback(code);
    }
  }

  Future<void> googleLogin(
    final VoidCallback onCompleteCallback,
    final Function(String errorCode) onErrorCallback,
  ) async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final user = await _auth.signInWithCredential(credential);
      _user = user.user!;
      onCompleteCallback();
    } on FirebaseAuthException catch (e) {
      String code = e.code.replaceAll('-', ' ');
      code = code[0].toUpperCase() + code.substring(1);
      onErrorCallback(code);
    }
  }
}
