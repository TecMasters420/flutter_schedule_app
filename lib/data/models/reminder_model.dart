import 'event_location_model.dart';
import 'event_status_enum.dart';
import 'tag_model.dart';
import 'task_model.dart';

class ReminderModel {
  final int id;
  String title;
  String description;
  DateTime? startDate;
  DateTime? endDate;
  EventStatus currentStatus;
  EventLocation? startLocation;
  EventLocation? endLocation;
  List<TaskModel> tasks;
  List<TagModel> tags;

  DateTime createdAt;
  DateTime updatedAt;

  ReminderModel({
    required this.id,
    required this.createdAt,
    required this.description,
    required this.title,
    required this.tasks,
    required this.tags,
    required this.currentStatus,
    required this.updatedAt,
    required this.endLocation,
    required this.startLocation,
    this.endDate,
    this.startDate,
  });

  double get progress =>
      (tasks.where((t) => t.isCompleted).length / tasks.length) * 100;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'creationDate': createdAt,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'title': title,
      'startLocation': startLocation,
      'endLocation': endLocation,
      'tasks': tasks.map((x) => x.toMap()).toList(),
      'tags': tags.map((x) => x.toMap()).toList(),
    };
  }

  factory ReminderModel.fromMap(final Map<String, dynamic> map) {
    final tasks = List.generate(map['tasks'].length, (x) => map['tasks'][x]);
    final tags = List.generate(map['tags'].length, (x) => map['tags'][x]);
    return ReminderModel(
      id: map['id'],
      createdAt: DateTime.parse(map['createdAt']),
      description: map['description'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['EndDate']),
      title: map['title'],
      endLocation: map['endLocation'] != null
          ? EventLocation.fromMap(map['endLocation'])
          : null,
      startLocation: map['startLocation'] != null
          ? EventLocation.fromMap(map['startLocation'])
          : null,
      tasks: tasks.map((e) => TaskModel.fromMap(e)).toList(),
      tags: tags.map((e) => TagModel.fromMap(e)).toList(),
      currentStatus: EventStatus.values.firstWhere((e) =>
          e.name.toString().toUpperCase() ==
          map['currentStatus'].toString().toUpperCase()),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  factory ReminderModel.empty() {
    return ReminderModel(
      id: 0,
      createdAt: DateTime.now(),
      description: '',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      title: '',
      tasks: [],
      tags: [],
      currentStatus: EventStatus.none,
      updatedAt: DateTime.now(),
      endLocation: null,
      startLocation: null,
    );
  }

  @override
  String toString() {
    return 'Event(creationDate: $createdAt, description: $description, endDate: $endDate, location: $endLocation, title: $title, tasks: $tasks, tags: $tags)';
  }

  Duration timeLeft(final DateTime date) {
    return endDate!.difference(date);
  }

  bool hasExpired(final DateTime date) {
    return date.isAfter(endDate!);
  }
}
