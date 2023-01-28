import 'package:get/get.dart';
import 'package:schedulemanager/data/models/event_model.dart';

import '../../events_page/services/events_page_service.dart';

class EventsDetailsCreationController extends GetxController {
  final EventsPageRepository _repo = EventsPageRepository();
  final Rx<EventModel?> event = Rx(null);
  final RxBool isLoading = RxBool(false);

  Future<void> getEvent(int id) async {
    isLoading.value = true;
    event.value = await _repo.getEvent(id);
    isLoading.value = false;
  }

  Future<bool> createEvent() async {
    if (event.value == null) return false;
    return await _repo.createEvent(event.value!);
  }

  void createEmpty() {
    event.value = EventModel.empty();
  }

  Future<bool> editEvent(int id) async {
    return await _repo.editEvent(id, event.value!);
  }
}
