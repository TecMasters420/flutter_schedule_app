import 'dart:ui';
import 'package:schedulemanager/data/models/event_model.dart';

class EventsTypeModel {
  final List<EventModel> events;
  final String label;
  final Color color;
  EventsTypeModel({
    required this.events,
    required this.label,
    required this.color,
  });
}
