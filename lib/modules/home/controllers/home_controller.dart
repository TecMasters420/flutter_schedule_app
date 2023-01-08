import 'package:get/get.dart';
import '../../../data/models/reminder_model.dart';
import '../services/home_services.dart';

class HomeController extends GetxController {
  final HomeRepository _repo = HomeRepository();
  RxList<ReminderModel> currentEvents = RxList([]);
  RxList<ReminderModel> expiredEvents = RxList([]);
  RxList<ReminderModel> nextEvents = RxList([]);

  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    getFilteredEvents();
    super.onInit();
  }

  Future<void> getFilteredEvents() async {
    isLoading.value = true;
    final res = await _repo.getFilteredEvents();
    if (res != null) {
      currentEvents.value = res.current;
      nextEvents.value = res.next;
      expiredEvents.value = res.expired;
    }
    isLoading.value = false;
  }
}
