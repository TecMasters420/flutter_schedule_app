import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/routes/app_routes.dart';
import '../app/config/constants.dart';
import '../modules/initial_page/bindings/initial_information_bindings.dart';
import '../modules/initial_page/initial_information_page.dart';
import '../routes/app_pages.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      initialBinding: const InitialInformationBindings(),
      getPages: appPages,
      home: const InitialInformationPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: accent),
      ),
    );
  }
}
