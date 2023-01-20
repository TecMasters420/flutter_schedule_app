import 'dart:convert';

import '../../../app/services/base_repository.dart';
import '../../../data/models/initial_announcement_model.dart';

class AnnouncementsRepository extends BaseRepository {
  Future<List<InitialAnnouncementModel>?> getAll() async {
    final res = await base.call('announcements');
    if (res != null) {
      final List<dynamic> json = jsonDecode(res.body);
      return json.map((e) => InitialAnnouncementModel.fromMap(e)).toList();
    }
    return null;
  }
}
