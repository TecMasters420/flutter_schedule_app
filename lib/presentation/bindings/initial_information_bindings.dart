import 'package:get/get.dart';

import '../../app/services/initial_announcements_service.dart';
import '../controllers/initial_announcements_controller.dart';

class InitialInformationBindings implements Bindings {
  const InitialInformationBindings();
  @override
  void dependencies() {
    Get.put<InitialAnnouncementsController>(InitialAnnouncementsController(),
        permanent: false);
    Get.put<InitialAnnouncementsService>(InitialAnnouncementsService(),
        permanent: false);
  }
}
