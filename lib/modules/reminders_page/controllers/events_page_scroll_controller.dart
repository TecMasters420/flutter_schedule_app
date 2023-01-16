import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EventsPageScrollController extends GetxController {
  final ScrollController controller = ScrollController();
  final RxDouble value = RxDouble(0);

  @override
  void onInit() {
    controller.addListener(listener);
    super.onInit();
  }

  void listener() {
    if (controller.hasClients) {
      value.value = controller.position.pixels;
    }
  }
}
