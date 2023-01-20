import 'package:get/get.dart';
import 'package:schedulemanager/modules/auth/controllers/login_controller.dart';

class LoginBindings implements Bindings {
  const LoginBindings();
  @override
  void dependencies() {
    Get.put(LoginController(), permanent: false);
  }
}
