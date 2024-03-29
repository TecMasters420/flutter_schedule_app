import '../../../data/models/event_model.dart';
import 'events_date_model.dart';

class DatesWithEventsModel {
  final int year;
  final List<EventsDateModel> dates;
  final List<EventModel> events;

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
      events:
          List.from(map['events']).map((e) => EventModel.fromMap(e)).toList(),
    );
  }

  @override
  String toString() => '(Date: $year  Dates: $dates)';
}
