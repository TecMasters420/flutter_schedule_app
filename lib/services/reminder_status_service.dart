import 'package:schedulemanager/services/base_service.dart';

class ReminderStatusService extends BaseService {
  static const _collection = 'ReminderStatus';

  final announcementsCollection =
      FirebaseFirestore.instance.collection(_collection);

  @override
  Future<void> create(Map<String, dynamic> data) async {}

  @override
  Future<void> delete(Map<String, dynamic> data) async {}

  @override
  Future<void> getData() async {}

  @override
  Future<void> update(Map<String, dynamic> data) async {}
}
