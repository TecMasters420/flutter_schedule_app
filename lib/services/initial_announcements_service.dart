import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedulemanager/services/base_service.dart';

class InitialAnnouncementsService extends BaseService {
  static const _collection = 'InitialAnnouncements';

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
