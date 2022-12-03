import 'package:get/get.dart';
import 'package:schedulemanager/presentation/controllers/reminders_controller.dart';

class RemindersBindings implements Bindings {
  const RemindersBindings();
  @override
  void dependencies() {
    Get.put<RemindersController>(RemindersController(), permanent: false);
  }
}
