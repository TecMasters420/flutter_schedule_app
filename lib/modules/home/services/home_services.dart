import 'dart:convert';

import 'package:get/instance_manager.dart';
import 'package:schedulemanager/common/request_base.dart';
import 'package:schedulemanager/modules/auth/controllers/auth_controller.dart';
import 'package:schedulemanager/modules/home/models/filtered_events_model.dart';

class HomeRepository {
  final RequestBase base = RequestBase();

  Future<FilteredEventsModel?> getFilteredEvents() async {
    final AuthController auth = Get.find();
    final res = await base.call('events', token: auth.token);
    if (res != null) {
      final json = jsonDecode(res);
      return FilteredEventsModel.fromMap(json);
    }
    return null;
  }
}
