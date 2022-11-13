import 'package:flutter/material.dart';
import 'package:schedulemanager/screens/home_page.dart';
import 'package:schedulemanager/screens/initial_information_page.dart';
import 'package:schedulemanager/screens/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:schedulemanager/screens/register_page.dart';
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
    return MaterialApp(
      title: 'Schedule Manager',
      debugShowCheckedModeBanner: false,
      home: const InitialInformationPage(),
      routes: {
        'initialInformationPage': (context) => const InitialInformationPage(),
        'loginPage': (context) => const LoginPage(),
        'homePage': (context) => const HomePage(),
        'registerPage': (context) => const RegisterPage(),
      },
    );
  }
}
