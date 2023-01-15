import 'package:get/get.dart';
import '../../../data/models/reminder_model.dart';
import '../models/dates_with_events_model.dart';
import '../models/events_date_model.dart';
import '../services/events_page_service.dart';

class EventsPageController extends GetxController {
  final EventsPageRepository _repo = EventsPageRepository();
  RxList<DatesWithEventsModel> datesWithEvents = RxList([]);
  RxList<ReminderModel> eventsInDate = RxList([]);
  RxBool isLoading = RxBool(false);
  RxBool gettingEventsList = RxBool(false);
  Rx<DateTime?> selectedDate = Rx(null);
  RxList<int> years = RxList([]);
  RxList<int> months = RxList([]);
  RxList<int> days = RxList([]);

  late DatesWithEventsModel sameYear;
  late EventsDateModel sameMonth;

  bool get hasEvents => eventsInDate.isNotEmpty;

  @override
  void onInit() async {
    await getDatesWithEvents();
    super.onInit();
  }

  Future<void> getDatesWithEvents() async {
    isLoading.value = true;
    final res = await _repo.getDatesWithEvents();
    if (res != null) {
      datesWithEvents.value = res;
      final year = res.first.year;
      final month = res.first.dates.first.month;
      final day = res.first.dates.first.days.first;
      selectedDate.value = DateTime(year, month, day);
      _setValues();
      await getEventsPerDate();
    }
    isLoading.value = false;
  }

  void _setValues() {
    sameYear =
        datesWithEvents.firstWhere((e) => e.year == selectedDate.value!.year);
    months.value = sameYear.dates.map((e) => e.month).toList();
    sameMonth =
        sameYear.dates.firstWhere((e) => e.month == selectedDate.value!.month);
    sameMonth.days.sort();
    days.value = sameMonth.days;
  }

  Future<void> getEventsPerDate() async {
    gettingEventsList.value = true;
    if (selectedDate.value != null) {
      eventsInDate.value = await _repo.getEventPerDate(selectedDate.value!);
    }
    gettingEventsList.value = false;
  }

  void setDate(DateTime date, {bool? genDay}) async {
    selectedDate.value = date;
    _setValues();
    if (genDay != null && genDay) {
      selectedDate.value = DateTime(date.year, date.month, days.first);
    }
    await getEventsPerDate();
  }
}
