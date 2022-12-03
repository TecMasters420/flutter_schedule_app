import 'base_service.dart';

class ReminderStatusService extends BaseService {
  static const _collection = 'ReminderStatus';

  final announcementsCollection =
      FirebaseFirestore.instance.collection(_collection);

  @override
  Future<void> createData(Map<String, dynamic> data) async {}

  @override
  Future<void> deleteData(Map<String, dynamic> data) async {}

  @override
  Future<void> getData([final String uid = '']) async {}

  @override
  Future<void> updateData(Map<String, dynamic> data) async {}
}
