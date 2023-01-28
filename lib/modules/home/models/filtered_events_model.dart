import '../../../data/models/event_model.dart';

class FilteredEventsModel {
  final List<EventModel> expired;
  final List<EventModel> next;
  final List<EventModel> current;

  const FilteredEventsModel({
    required this.expired,
    required this.next,
    required this.current,
  });

  factory FilteredEventsModel.fromMap(Map<String, dynamic> map) {
    final tempExpired =
        map['expiredEvents'] == null ? [] : List.from(map['expiredEvents']);
    final tempNext =
        map['nextEvents'] == null ? [] : List.from(map['nextEvents']);
    final tempCurrent =
        map['currentEvents'] == null ? [] : List.from(map['currentEvents']);
    return FilteredEventsModel(
      expired: tempExpired.map((e) => EventModel.fromMap(e)).toList(),
      next: tempNext.map((e) => EventModel.fromMap(e)).toList(),
      current: tempCurrent.map((e) => EventModel.fromMap(e)).toList(),
    );
  }
}
