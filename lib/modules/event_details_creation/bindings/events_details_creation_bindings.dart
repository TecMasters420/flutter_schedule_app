import 'package:get/get.dart';
import 'package:schedulemanager/modules/event_details_creation/controller/events_details_creation_controller.dart';

class EventsDetailsCreationBindings implements Bindings {
  const EventsDetailsCreationBindings();

  @override
  void dependencies() {
    Get.put(EventsDetailsCreationController());
  }
}
