import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final User? _user;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool get userIsLogged => _auth.currentUser != null;
  User? get user => _user;

  String getErrorMessage(final String errorCode) {
    String message = errorCode.replaceAll('-', ' ');
    return message[0].toUpperCase() + message.substring(1);
  }

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
      onErrorCallback(getErrorMessage(e.code));
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
      notifyListeners();
      onCompleteCallback();
    } on FirebaseAuthException catch (e) {
      onErrorCallback(getErrorMessage(e.code));
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
      onErrorCallback(getErrorMessage(e.code));
    }
  }
}
