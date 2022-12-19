import 'package:get/get.dart';
import 'package:schedulemanager/modules/reminders_page/controllers/events_page_controller.dart';

class EventsPageBindings implements Bindings {
  const EventsPageBindings();

  @override
  void dependencies() {
    Get.put(EventsPageController(), permanent: false);
  }
}
