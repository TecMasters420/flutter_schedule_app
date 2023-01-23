import '../../data/models/reminder_model.dart';

abstract class EventsRepository {
  Future<List<EventModel>> getAllEvents();
  Future<Map<String, List<EventModel>>> getFilteredEvents();
  Future<List<EventModel>> getEvent(final int id);
  Future<List<EventModel>> getEventsPerDate(final DateTime date);
}
