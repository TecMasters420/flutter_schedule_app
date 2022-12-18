import 'package:schedulemanager/data/datasources/schedule_app_api.dart';
import 'package:schedulemanager/data/models/reminder_model.dart';
import 'package:schedulemanager/domain/repositories/events_repository.dart';

class EventsRepositoryIml extends EventsRepository {
  final ScheduleAppApi _api = ScheduleAppApi();

  @override
  Future<List<ReminderModel>> getAllEvents() async {
    return await _api.getAllEvents();
  }

  @override
  Future<List<ReminderModel>> getEvent(int id) async {
    return [];
  }

  @override
  Future<Map<String, List<ReminderModel>>> getFilteredEvents() async {
    return await _api.getFilteredEvents();
  }

  @override
  Future<List<ReminderModel>> getEventsPerDate(DateTime date) async {
    return await _api.getEventsPerDate(date);
  }
}
