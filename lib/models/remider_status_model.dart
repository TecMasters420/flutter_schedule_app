// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReminderStatusModel {
  final String status;
  const ReminderStatusModel({required this.status});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
    };
  }

  factory ReminderStatusModel.fromMap(Map<String, dynamic> map) {
    return ReminderStatusModel(
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());
}
