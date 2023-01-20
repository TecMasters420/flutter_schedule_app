import 'dart:convert';
import 'package:get/instance_manager.dart';
import '../../../app/services/base_repository.dart';
import '../../../data/models/reminder_model.dart';
import '../../auth/controllers/auth_controller.dart';
import '../models/dates_with_events_model.dart';

class EventsPageRepository extends BaseRepository {
  Future<List<ReminderModel>> getEventPerDate(DateTime date) async {
    final formatDate = '${date.year}-${date.month}-${date.day}';
    final AuthController auth = Get.find();
    final res = await base.call('events/perDate/date?end=$formatDate',
        token: auth.token);
    if (res != null) {
      final json = jsonDecode(res.body);
      return List.from(json).map((e) => ReminderModel.fromMap(e)).toList();
    }
    return [];
  }

  Future<List<DatesWithEventsModel>?> getDatesWithEvents() async {
    final AuthController auth = Get.find();
    final res = await base.call('events/getDates', token: auth.token);
    if (res != null) {
      final List<dynamic> json = jsonDecode(res.body);
      return json.map((e) => DatesWithEventsModel.fromMap(e)).toList();
    }
    return null;
  }
}
