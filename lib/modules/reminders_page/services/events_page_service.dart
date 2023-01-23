import 'dart:convert';
import 'package:get/instance_manager.dart';
import '../../../app/services/base_repository.dart';
import '../../../data/models/event_model.dart';
import '../../auth/controllers/auth_controller.dart';
import '../models/dates_with_events_model.dart';

class EventsPageRepository extends BaseRepository {
  Future<List<EventModel>> getEventPerDate(DateTime date) async {
    final formatDate = '${date.year}-${date.month}-${date.day}';
    final AuthController auth = Get.find();
    final res = await base.call(
      'events/perDate/date?end=$formatDate',
      token: auth.token,
    );
    if (res != null) {
      final json = jsonDecode(res.body);
      return List.from(json).map((e) => EventModel.fromMap(e)).toList();
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

  Future<void> createEvent(EventModel event) async {
    final AuthController auth = Get.find();
    final res = await base.call(
      'events/',
      token: auth.token,
      body: event.toMap(),
    );
    if (res != null) {
      // final json = jsonDecode(res.body);
      print(res.body);
    }
  }

  Future<EventModel?> getEvent(int id) async {
    final AuthController auth = Get.find();
    final res = await base.call(
      'events/$id',
      token: auth.token,
    );
    if (res != null) {
      if (res.code == 200) {
        return EventModel.fromMap(jsonDecode(res.body));
      }
    }
    return null;
  }

  Future<void> editEvent(int id, EventModel event) async {
    final AuthController auth = Get.find();
    await base.call(
      'events/$id',
      token: auth.token,
      body: event.toMap(),
      edit: true,
    );
  }
}
