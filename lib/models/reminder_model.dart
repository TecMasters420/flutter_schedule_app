import 'package:cloud_firestore/cloud_firestore.dart';
import 'tag_model.dart';
import 'task_model.dart';

class ReminderModel {
  final String? id;
  Timestamp creationDate;
  String description;
  String title;
  String uid;
  List<TaskModel> tasks;
  List<TagModel> tags;
  Timestamp endDate;
  Timestamp startDate;

  int? expectedTemp;
  GeoPoint? startLocation;
  GeoPoint? endLocation;
  String? address;

  ReminderModel({
    required this.creationDate,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.endLocation,
    required this.startLocation,
    required this.title,
    required this.uid,
    required this.expectedTemp,
    required this.tasks,
    required this.tags,
    required this.address,
    this.id,
  });

  double get progress =>
      (tasks.where((t) => t.isCompleted).length / tasks.length) * 100;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'creationDate': creationDate,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'location': endLocation,
      'title': title,
      'uid': uid,
      'startLocation': startLocation,
      'expectedTemp': expectedTemp,
      'address': address,
      'tasks': tasks.map((x) => x.toMap()).toList(),
      'tags': tags.map((x) => x.toMap()).toList(),
    };
  }

  factory ReminderModel.fromMap(
      final Map<String, dynamic> map, final String id) {
    final tasks = List.generate(
        map['tasks'].length, (x) => map['tasks'][x] as Map<String, dynamic>);
    final tags = List.generate(
        map['tags'].length, (x) => map['tags'][x] as Map<String, dynamic>);
    return ReminderModel(
      id: id,
      creationDate: map['creationDate'],
      description: map['description'],
      startDate: map['startDate'],
      startLocation: map['startLocation'],
      endDate: map['endDate'],
      endLocation: map['location'],
      title: map['title'],
      uid: map['uid'],
      address: map['address'],
      expectedTemp: map['expectedTemp'],
      tasks: tasks.map((e) => TaskModel.fromMap(e)).toList(),
      tags: tags.map((e) => TagModel.fromMap(e)).toList(),
    );
  }

  @override
  String toString() {
    return 'Reminder(creationDate: $creationDate, description: $description, endDate: $endDate, location: $endLocation, title: $title, uid: $uid, expectedTemp: $expectedTemp, tasks: $tasks, tags: $tags)';
  }

  Duration timeLeft(final DateTime date) {
    return endDate.toDate().difference(date);
  }

  bool hasExpired(final DateTime date) {
    return date.isAfter(endDate.toDate());
  }
}
