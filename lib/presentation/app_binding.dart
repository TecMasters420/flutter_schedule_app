import 'package:get/get.dart';
import 'package:schedulemanager/presentation/controllers/auth_controller.dart';
import 'package:schedulemanager/presentation/controllers/reminders_controller.dart';

class AppBinding implements Bindings {
  const AppBinding();
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(RemindersController());
  }
}
