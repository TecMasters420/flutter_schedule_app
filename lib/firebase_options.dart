// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAnIGWP2WBMwWjIq8xi-5TSiWPOK53D23s',
    appId: '1:760990865871:web:4c24eabbe2c3444b4d1aba',
    messagingSenderId: '760990865871',
    projectId: 'schedule-manager-ab373',
    authDomain: 'schedule-manager-ab373.firebaseapp.com',
    storageBucket: 'schedule-manager-ab373.appspot.com',
    measurementId: 'G-W8PRS34ME0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8cY1IqBdYz63_dATJNyz_4CvqdbEHwBQ',
    appId: '1:760990865871:android:5fac5f4853be22f14d1aba',
    messagingSenderId: '760990865871',
    projectId: 'schedule-manager-ab373',
    storageBucket: 'schedule-manager-ab373.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBgn94WEVUqlkl1QoCwHTZHEXMoUDJbRUk',
    appId: '1:760990865871:ios:e1078d24294d4b6f4d1aba',
    messagingSenderId: '760990865871',
    projectId: 'schedule-manager-ab373',
    storageBucket: 'schedule-manager-ab373.appspot.com',
    iosClientId: '760990865871-f0f01dd2ep2ikgkanvvdu6ctb9dm7e2a.apps.googleusercontent.com',
    iosBundleId: 'com.example.scheduleApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBgn94WEVUqlkl1QoCwHTZHEXMoUDJbRUk',
    appId: '1:760990865871:ios:e1078d24294d4b6f4d1aba',
    messagingSenderId: '760990865871',
    projectId: 'schedule-manager-ab373',
    storageBucket: 'schedule-manager-ab373.appspot.com',
    iosClientId: '760990865871-f0f01dd2ep2ikgkanvvdu6ctb9dm7e2a.apps.googleusercontent.com',
    iosBundleId: 'com.example.scheduleApp',
  );
}