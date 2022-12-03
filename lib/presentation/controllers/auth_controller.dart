import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:schedulemanager/presentation/pages/home_page/home_page.dart';

import '../../app/services/base_service.dart';
import '../../data/models/user_model.dart';

class AuthController extends GetxController {
  static const String _collection = 'Users';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSign = GoogleSignIn();

  late final Rx<User?> user;
  late final Rx<UserModel?> userInformation;

  @override
  void onInit() async {
    super.onInit();
    user = Rx<User?>(_auth.currentUser);
    userInformation = Rx<UserModel?>(null);
    if (user.value != null) await updateUserFireStore();
    user.bindStream(_auth.userChanges());
    ever(user, _initialScreen);
  }

  void _showError(final String error) {
    String errorMessage = error.replaceAll('-', ' ');
    errorMessage = errorMessage[0].toUpperCase() + errorMessage.substring(1);
    Get.snackbar(
      'Error!',
      errorMessage,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(milliseconds: 1500),
      forwardAnimationCurve: Curves.ease,
      reverseAnimationCurve: Curves.ease,
      colorText: Colors.white,
      backgroundColor: Colors.red[400],
      icon: const Icon(Icons.add_alert, color: Colors.white),
    );
  }

  _initialScreen(User? user) {
    Get.toNamed(user == null || userInformation.value == null
        ? '/initialInformationPage'
        : '/homePage');
  }

  Future<void> googleLogin() async {
    try {
      final googleUser = await _googleSign.signIn();
      final googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final resUser = await _auth.signInWithCredential(credential);
      user.value = resUser.user!;
      await updateUserFireStore();
      Get.to(() => const HomePage());
    } on FirebaseAuthException catch (e) {
      _showError(e.code);
    }
  }

  Future<void> createUser(final String email, final String password) async {
    try {
      final res = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.value = res.user!;
    } on FirebaseAuthException catch (e) {
      _showError(e.code);
    }
  }

  Future<void> updateUserFireStore() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    final User currentUser = user.value!;
    final UserModel tempUser = UserModel(
      uid: currentUser.uid,
      displayName: currentUser.displayName,
      email: currentUser.email,
      emailVerified: currentUser.emailVerified,
      phoneNumber: currentUser.phoneNumber,
      createdAt: currentUser.metadata.creationTime,
      imageURL: currentUser.photoURL,
      lastLoginAt: currentUser.metadata.lastSignInTime!,
      fcmToken: fcmToken!,
    );
    await FirebaseFirestore.instance
        .collection(_collection)
        .doc(currentUser.uid)
        .set(tempUser.toMap(), SetOptions(merge: true))
        .then((value) => userInformation.value = tempUser);
  }

  Future<void> login(final String email, final String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.value = userCredential.user!;
      await updateUserFireStore();
      Get.to(() => const HomePage());
    } on FirebaseAuthException catch (e) {
      _showError(e.code);
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
