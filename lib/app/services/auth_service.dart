import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:schedulemanager/data/models/user_model.dart';
import 'package:schedulemanager/app_docker/app/services/base_service.dart';

class AuthService with ChangeNotifier {
  static const String _collection = 'Users';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final User? _user;
  late final UserModel _userInformation;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool get userIsLogged => _auth.currentUser != null;
  User? get user => _user;
  UserModel? get userInformation => _userInformation;

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

  Future<void> updateUserFireStore(final User loggedUser) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    final UserModel user = UserModel(
      uid: loggedUser.uid,
      displayName: loggedUser.displayName ?? '',
      email: loggedUser.email,
      emailVerified: loggedUser.emailVerified,
      phoneNumber: loggedUser.phoneNumber ?? '',
      createdAt: loggedUser.metadata.creationTime ?? DateTime.now(),
      imageURL: loggedUser.photoURL ?? '',
      lastLoginAt: loggedUser.metadata.lastSignInTime!,
      fcmToken: fcmToken!,
    );
    await FirebaseFirestore.instance
        .collection(_collection)
        .doc(loggedUser.uid)
        .set(user.toMap(), SetOptions(merge: true))
        .then((value) => _userInformation = user);
    // FirebaseFirestore.instance.collection(_collection).
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
      await updateUserFireStore(_user!);
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
      await updateUserFireStore(_user!);
      notifyListeners();
      onCompleteCallback();
    } on FirebaseAuthException catch (e) {
      onErrorCallback(getErrorMessage(e.code));
    }
  }
}
