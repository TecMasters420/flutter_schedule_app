import 'package:flutter/material.dart';
import 'package:schedule_app/screens/home_page.dart';
import 'package:schedule_app/screens/initial_information_page.dart';
import 'package:schedule_app/screens/login_page.dart';

void main() => runApp(const MyApp());

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
      },
    );
  }
}
