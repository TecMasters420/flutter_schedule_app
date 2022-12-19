import 'package:schedulemanager/data/models/reminder_model.dart';
import 'package:schedulemanager/modules/reminders_page/models/events_date_model.dart';

class DatesWithEventsModel {
  final int year;
  final List<EventsDateModel> dates;
  final List<ReminderModel> events;

  const DatesWithEventsModel({
    required this.year,
    required this.dates,
    required this.events,
  });

  factory DatesWithEventsModel.fromMap(Map<String, dynamic> map) {
    return DatesWithEventsModel(
      year: map['year'],
      dates: List.from(map['date'])
          .map((e) => EventsDateModel.fromMap(e))
          .toList(),
      events: List.from(map['events'])
          .map((e) => ReminderModel.fromMap(e))
          .toList(),
    );
  }

  @override
  String toString() => 'Date: $year  Dates: $dates';
}
