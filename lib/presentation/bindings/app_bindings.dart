import 'package:get/get.dart';
import 'package:schedulemanager/modules/auth/bindings/auth_bindings.dart';

class AppBindings implements Bindings {
  const AppBindings();
  @override
  void dependencies() {
    const AuthBindings().dependencies();
  }
}
