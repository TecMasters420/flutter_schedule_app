import 'dart:convert';

import 'package:get/instance_manager.dart';
import '../../../common/request_base.dart';
import '../../auth/controllers/auth_controller.dart';
import '../models/filtered_events_model.dart';

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
