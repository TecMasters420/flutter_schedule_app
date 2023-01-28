import 'package:get/get.dart';
import 'package:schedulemanager/modules/map_page/controller/map_page_controller.dart';

class MapPageBindings implements Bindings {
  const MapPageBindings();

  @override
  void dependencies() {
    Get.lazyPut(() => MapPageController());
  }
}
