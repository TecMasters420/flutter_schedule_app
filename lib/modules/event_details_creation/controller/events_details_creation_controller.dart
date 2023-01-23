import 'package:get/get.dart';
import 'package:schedulemanager/data/models/event_model.dart';

import '../../reminders_page/services/events_page_service.dart';

class EventsDetailsCreationController extends GetxController {
  final EventsPageRepository _repo = EventsPageRepository();
  final Rx<EventModel?> event = Rx(null);
  final RxBool isLoading = RxBool(false);

  Future<void> getEvent(int id) async {
    isLoading.value = true;
    event.value = await _repo.getEvent(id);
    isLoading.value = false;
  }

  Future<void> createEvent() async {
    if (event.value == null) return;
    isLoading.value = true;
    await _repo.createEvent(event.value!);
    isLoading.value = false;
  }

  void createEmpty() {
    event.value = EventModel.empty();
  }

  Future<void> editEvent(int id) async {
    isLoading.value = true;
    await _repo.editEvent(id, event.value!);
    isLoading.value = false;
  }
}
