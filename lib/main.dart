import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/modules/auth/controllers/auth_controller.dart';
import 'app/config/enviorment.dart';
import 'presentation/app.dart';
import 'presentation/bindings/app_bindings.dart';
import 'app/services/flutter_notification.dart';

// import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('Testing : ${const String.fromEnvironment('TMDB_KEY')}');
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
    options: const FirebaseOptions(
      apiKey: Enviorment.fireBaseApiKey,
      appId: Enviorment.fireBaseAppID,
      messagingSenderId: Enviorment.fireBaseMessagingSenderId,
      projectId: Enviorment.fireBaseProjectID,
    ),
  ).then((value) {
    const AppBindings().dependencies();
  });

  if (!kIsWeb) {
    final AuthController auth = Get.find();
    auth.fmcToken = await FirebaseMessaging.instance.getToken();

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      auth.fmcToken = fcmToken;
    }).onError((err) {
      debugPrint('Error getting FMCToken');
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        sendNotification(
            body: message.notification!.body,
            title: message.notification!.title);
      } else {
        debugPrint('has not notification');
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
