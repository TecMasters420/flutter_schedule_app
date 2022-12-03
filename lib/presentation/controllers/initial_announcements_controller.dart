import 'package:get/get.dart';

class InitialAnnouncementsController extends GetxController {
  RxInt currentIndex = 0.obs;

  void setNewIndex(final int index) {
    currentIndex.value = index;
  }
}
