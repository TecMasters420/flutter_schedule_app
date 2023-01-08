import 'package:get/get.dart';
import '../../../data/models/initial_announcement_model.dart';
import '../services/announcements_repository.dart';

class InitialAnnouncementsController extends GetxController {
  final AnnouncementsRepository _repo = AnnouncementsRepository();
  RxList<InitialAnnouncementModel> announces = RxList([]);
  RxBool isLoading = RxBool(true);

  int get quantity => announces.length;

  @override
  void onInit() async {
    await getAnnouncements();
    super.onInit();
  }

  Future<void> getAnnouncements() async {
    isLoading.value = true;
    final res = await _repo.getAll();
    if (res != null) {
      announces.value = res;
    }
    isLoading.value = false;
  }
}
