import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedulemanager/models/tag_model.dart';
import 'package:schedulemanager/models/task_model.dart';

class ReminderModel {
  final Timestamp creationDate;
  final String description;
  final Timestamp startDate;
  final Timestamp endDate;
  final GeoPoint? location;
  final String title;
  final String uid;
  final int expectedTemp;
  final List<TaskModel> tasks;
  final List<TagModel> tags;
  ReminderModel({
    required this.creationDate,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.title,
    required this.uid,
    required this.expectedTemp,
    required this.tasks,
    required this.tags,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'creationDate': creationDate,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'title': title,
      'uid': uid,
      'expectedTemp': expectedTemp,
      'tasks': tasks.map((x) => x.toMap()).toList(),
      'tags': tags.map((x) => x.toMap()).toList(),
    };
  }

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    final tasks = List.generate(
        map['tasks'].length, (x) => map['tasks'][x] as Map<String, dynamic>);
    final tags = List.generate(
        map['tags'].length, (x) => map['tags'][x] as Map<String, dynamic>);
    return ReminderModel(
      creationDate: map['creationDate'],
      description: map['description'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      location: map['location'],
      title: map['title'],
      uid: map['uid'],
      expectedTemp: map['expectedTemp'],
      tasks: tasks.map((e) => TaskModel.fromMap(e)).toList(),
      tags: tags.map((e) => TagModel.fromMap(e)).toList(),
    );
  }

  @override
  String toString() {
    return 'Reminder(creationDate: $creationDate, description: $description, endDate: $endDate, location: $location, title: $title, uid: $uid, expectedTemp: $expectedTemp, tasks: $tasks, tags: $tags)';
  }

  Duration timeLeft(final DateTime date) {
    return endDate.toDate().difference(date);
  }

  bool hasExpired(final DateTime date) {
    return date.isAfter(endDate.toDate());
  }
}
