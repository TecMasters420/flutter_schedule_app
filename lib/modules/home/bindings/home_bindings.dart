import 'package:get/get.dart';
import 'package:schedulemanager/modules/home/controllers/home_controller.dart';

class HomeBindings implements Bindings {
  const HomeBindings();
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
  }
}
