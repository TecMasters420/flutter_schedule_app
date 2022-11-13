import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder {
  final Timestamp date;
  final String description;
  final Map<String, dynamic> duration;
  final dynamic location;
  final String title;

  const Reminder({
    required this.date,
    required this.description,
    required this.duration,
    required this.location,
    required this.title,
  });

  factory Reminder.fromJson(final Map<String, dynamic> json) {
    return Reminder(
      date: json['date'],
      description: json['description'],
      duration: json['duration'],
      location: json['location'],
      title: json['title'],
    );
  }
}
