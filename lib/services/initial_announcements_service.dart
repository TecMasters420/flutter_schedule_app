import 'package:flutter/cupertino.dart';
import '../models/initial_announcement_model.dart';
import 'base_service.dart';

class InitialAnnouncementsService extends BaseService with ChangeNotifier {
  static const _collection = 'InitialAnnouncements';

  final collection = FirebaseFirestore.instance.collection(_collection);

  late List<InitialAnnouncementModel> announces;
  late bool isLoaded;

  InitialAnnouncementsService() {
    announces = [];
    isLoaded = false;
    getData();
  }

  @override
  Future<void> create(Map<String, dynamic> data) async {}

  @override
  Future<void> delete(Map<String, dynamic> data) async {}

  @override
  Future<void> getData([final String uid = '']) async {
    announces = await collection.get().then((snapshot) => snapshot.docs
        .map((e) => InitialAnnouncementModel.fromMap(e.data()))
        .toList());
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      isLoaded = true;
      notifyListeners();
    });
  }

  @override
  Future<void> update(Map<String, dynamic> data) async {}
}
