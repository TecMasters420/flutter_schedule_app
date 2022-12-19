// import 'package:get/get.dart';

// import '../../data/models/initial_announcement_model.dart';
// import 'base_repository.dart';

// class InitialAnnouncementsService extends GetxController
//     implements BaseRepository {
//   static const _collection = 'InitialAnnouncements';

//   final collection = FirebaseFirestore.instance.collection(_collection);

//   Rx<List<InitialAnnouncementModel>> announces =
//       Rx<List<InitialAnnouncementModel>>([]);

//   int get announcementsQuantity => announces.value.length;

//   RxBool isLoaded = false.obs;

//   @override
//   void onInit() async {
//     super.onInit();
//     await getData();
//   }

//   @override
//   Future<void> createData(Map<String, dynamic> data) async {}

//   @override
//   Future<void> deleteData(Map<String, dynamic> data) async {}

//   @override
//   Future<void> getData([final String uid = '']) async {
//     announces.value = await collection.get().then((snapshot) => snapshot.docs
//         .map((e) => InitialAnnouncementModel.fromMap(e.data()))
//         .toList());
//     Future.delayed(const Duration(milliseconds: 500)).then((value) {
//       isLoaded.value = true;
//     });
//   }

//   @override
//   Future<void> updateData(Map<String, dynamic> data) async {}
// }
