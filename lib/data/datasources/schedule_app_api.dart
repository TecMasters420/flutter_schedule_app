import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:schedulemanager/data/models/reminder_model.dart';

const String _apiBase = 'http://192.168.1.21:9090/api/v1';
const String _eventsEndPoint = 'events';
const String _filterPerDateEndPoint = 'perDate/date?end';
const String _token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJ1c2VybmFtZSI6ImZyYW5rIiwicGFzc3dvcmQiOiJmcmFua2ZyYW5rZnJhbmsifSwiaWF0IjoxNjcxMzM2NzY3LCJleHAiOjE2NzE0MDg3Njd9.zumQ06nVI3E4J4BL44Tdji-3iL5Gs6tLEJEx7RnAuWw';

class ScheduleAppApi {
  Future<Map<String, List<ReminderModel>>> getFilteredEvents() async {
    try {
      final url = Uri.parse('$_apiBase/$_eventsEndPoint');
      final http.Response res =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      if (res.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(res.body);
        final expiredEvents = List.from(json['expiredEvents'])
            .map((e) => ReminderModel.fromMap(e))
            .toList();
        final currentEvents = List.from(json['currentEvents'])
            .map((e) => ReminderModel.fromMap(e))
            .toList();
        final nextEvents = List.from(json['nextEvents'])
            .map((e) => ReminderModel.fromMap(e))
            .toList();
        final temp = {
          'Expired': expiredEvents,
          'Current': currentEvents,
          'Next': nextEvents,
        };
        return temp;
      }
      return {};
    } catch (e) {
      debugPrint(e.toString());
    }
    return {};
  }

  Future<List<ReminderModel>> getEventsPerDate(final DateTime date) async {
    try {
      final url = Uri.parse(
          '$_apiBase/$_eventsEndPoint/$_filterPerDateEndPoint=${date.year}-${date.month}-${date.day}');
      final http.Response res =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      if (res.statusCode == 200) {
        final List<dynamic> json = jsonDecode(res.body);
        return json.map((e) => ReminderModel.fromMap(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
