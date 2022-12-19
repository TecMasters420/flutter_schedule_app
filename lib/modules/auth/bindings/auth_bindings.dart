import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AuthBindings implements Bindings {
  const AuthBindings();
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}
