import '../../data/models/reminder_model.dart';

abstract class EventsRepository {
  Future<List<ReminderModel>> getAllEvents();
  Future<Map<String, List<ReminderModel>>> getFilteredEvents();
  Future<List<ReminderModel>> getEvent(final int id);
  Future<List<ReminderModel>> getEventsPerDate(final DateTime date);
}
