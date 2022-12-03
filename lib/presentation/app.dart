import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/presentation/pages/initial_page/initial_information_page.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    throw const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      initialBinding: null,
      home: InitialInformationPage(),
    );
  }
}
