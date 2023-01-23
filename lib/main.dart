import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:schedulemanager/modules/auth/controllers/auth_controller.dart';
import 'domain/map_api.dart';
import 'presentation/app.dart';
import 'presentation/bindings/app_bindings.dart';
import 'app/services/flutter_notification.dart';

import 'firebase_options.dart';

const devMode = true;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    const AppBindings().dependencies();
  });

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
          body: message.notification!.body, title: message.notification!.title);
    } else {
      debugPrint('has not notification');
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MapApi>(create: (context) => MapApi()),
      ],
      child: const App(),
    );
  }
}
