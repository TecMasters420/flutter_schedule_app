class EventsDateModel {
  final int month;
  final List<int> days;

  const EventsDateModel({
    required this.month,
    required this.days,
  });

  factory EventsDateModel.fromMap(Map<String, dynamic> map) {
    return EventsDateModel(
      month: map['month'],
      days: List<int>.from(map['days']),
    );
  }

  @override
  String toString() => 'Month: $month Days: $days';
}
