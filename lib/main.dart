import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/modules/auth/controllers/auth_controller.dart';
import 'presentation/app.dart';
import 'presentation/bindings/app_bindings.dart';
import 'app/services/flutter_notification.dart';

<<<<<<< HEAD
import 'screens/home_page/home_page.dart';
import 'screens/initial_page/initial_information_page.dart';
import 'screens/login_page/login_page.dart';
import 'screens/map_page/map_page.dart';
import 'screens/register_page/register_page.dart';
import 'screens/reminder_details_page/reminders_details_page.dart';
import 'screens/reminders_page/reminders_page.dart';
import 'screens/user_profile_page/user_profile_page.dart';
import 'services/auth_service.dart';
import 'services/initial_announcements_service.dart';
import 'services/reminder_service.dart';
import 'package:flutter/services.dart';
=======
import 'firebase_options.dart';
>>>>>>> dev

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
<<<<<<< HEAD
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  FirebaseMessaging.instance.onTokenRefresh
      .listen((fcmToken) {})
      .onError((err) {});
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');

    if (message.notification != null) {
      sendNotification(
          body: message.notification!.body, title: message.notification!.title);
    } else {
      debugPrint('has not notification');
    }
=======
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    const AppBindings().dependencies();
>>>>>>> dev
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
