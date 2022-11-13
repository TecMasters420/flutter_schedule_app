import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final User user;

  AuthService();

  void createUser(
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
      user = res.user!;
      onCompleteCallback();
    } on FirebaseAuthException catch (e) {
      String code = e.code.replaceAll('-', ' ');
      code = code[0].toUpperCase() + code.substring(1);
      onErrorCallback(code);
    }
  }

  void login(
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
      user = userCredential.user!;
      onCompleteCallback();
    } on FirebaseAuthException catch (e) {
      String code = e.code.replaceAll('-', ' ');
      code = code[0].toUpperCase() + code.substring(1);
      onErrorCallback(code);
    }
  }
}
