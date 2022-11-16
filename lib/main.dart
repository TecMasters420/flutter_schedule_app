import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedulemanager/providers/activities_provider.dart';
import 'package:schedulemanager/screens/activities_details_page/activities_details_page.dart';
import 'package:schedulemanager/screens/home_page/home_page.dart';
import 'package:schedulemanager/screens/initial_page/initial_information_page.dart';
import 'package:schedulemanager/screens/login_page/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:schedulemanager/screens/map_page/map_page.dart';
import 'package:schedulemanager/screens/register_page/register_page.dart';
import 'package:schedulemanager/screens/reminders_page/reminders_page.dart';
import 'package:schedulemanager/screens/user_profile_page/user_profile_page.dart';
import 'package:schedulemanager/services/auth_service.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (context) => AuthService()),
        ChangeNotifierProvider<ActivitiesProvider>(
            create: (context) => ActivitiesProvider()),
      ],
      child: MaterialApp(
        title: 'Schedule Manager',
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        routes: {
          'initialInformationPage': (context) => const InitialInformationPage(),
          'loginPage': (context) => const LoginPage(),
          'homePage': (context) => const HomePage(),
          'registerPage': (context) => const RegisterPage(),
          'activitiesDetailsPage': (context) => const ActivitiesDetailsPage(),
          'remindersPage': (context) => const RemindersPage(),
          'userProfilePage': (context) => const UserProfilePage(),
          'mapPage': (context) => const MapPage(),
        },
      ),
    );
  }
}
