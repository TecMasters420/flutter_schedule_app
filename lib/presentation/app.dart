import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/presentation/bindings/initial_information_bindings.dart';
import 'package:schedulemanager/presentation/pages/initial_page/initial_information_page.dart';
import 'package:schedulemanager/presentation/routes/app_pages.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/initialInformationPage',
      initialBinding: InitialInformationBindings(),
      getPages: appPages,
      home: const InitialInformationPage(),
    );
  }
}
