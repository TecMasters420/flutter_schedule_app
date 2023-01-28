import 'package:get/get.dart';
import 'package:schedulemanager/modules/auth/controllers/register_controller.dart';

class RegisterBindings implements Bindings {
  const RegisterBindings();
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}
