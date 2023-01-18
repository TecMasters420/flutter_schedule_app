import 'package:get/get.dart';
import 'package:schedulemanager/modules/navbar/controllers/navbar_controller.dart';
import '../controllers/home_controller.dart';

class HomeBindings implements Bindings {
  const HomeBindings();
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
    Get.put(NavBarController(), permanent: true);
  }
}
