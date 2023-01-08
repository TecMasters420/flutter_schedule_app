import '../../../data/models/reminder_model.dart';

class FilteredEventsModel {
  final List<ReminderModel> expired;
  final List<ReminderModel> next;
  final List<ReminderModel> current;

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
      expired: tempExpired.map((e) => ReminderModel.fromMap(e)).toList(),
      next: tempNext.map((e) => ReminderModel.fromMap(e)).toList(),
      current: tempCurrent.map((e) => ReminderModel.fromMap(e)).toList(),
    );
  }
}
