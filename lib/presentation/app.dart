import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/modules/initial_page/bindings/initial_information_bindings.dart';
import 'package:schedulemanager/modules/initial_page/initial_information_page.dart';
import 'package:schedulemanager/routes/app_pages.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/initialInformationPage',
      initialBinding: const InitialInformationBindings(),
      getPages: appPages,
      home: const InitialInformationPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xfffcfbff),
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: accent),
      ),
    );
  }
}
