import 'dart:convert';
import 'package:get/instance_manager.dart';
import 'package:schedulemanager/app/services/base_repository.dart';
import 'package:schedulemanager/data/models/reminder_model.dart';
import 'package:schedulemanager/modules/auth/controllers/auth_controller.dart';
import 'package:schedulemanager/modules/reminders_page/models/dates_with_events_model.dart';

class EventsPageRepository extends BaseRepository {
  Future<List<ReminderModel>> getEventPerDate(DateTime date) async {
    final formatDate = '${date.year}-${date.month}-${date.day}';
    final AuthController auth = Get.find();
    final res = await base.call('events/perDate/date?end=$formatDate',
        token: auth.token);
    if (res != null) {
      final json = jsonDecode(res);
      return List.from(json).map((e) => ReminderModel.fromMap(e)).toList();
    }
    return [];
  }

  Future<List<DatesWithEventsModel>?> getDatesWithEvents() async {
    final AuthController auth = Get.find();
    final res = await base.call('events/getDates', token: auth.token);
    if (res != null) {
      final List<dynamic> json = jsonDecode(res);
      return json.map((e) => DatesWithEventsModel.fromMap(e)).toList();
    }
    return null;
  }
}
