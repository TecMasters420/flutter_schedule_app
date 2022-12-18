import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/app/services/base_service.dart';
import 'package:schedulemanager/data/repositories/events_repository_iml.dart';

import '../../data/models/reminder_model.dart';

class RemindersController extends GetxController implements BaseService {
  static const String _collection = 'Reminder';

  final db = FirebaseFirestore.instance.collection(_collection);

  final EventsRepositoryIml _repo = EventsRepositoryIml();

  final RxBool isLoading = true.obs;
  final Rx<List<ReminderModel>> _reminders = Rx<List<ReminderModel>>([]);
  final Rx<List<ReminderModel>> _expiredEvents = Rx<List<ReminderModel>>([]);
  final Rx<List<ReminderModel>> _nextEvents = Rx<List<ReminderModel>>([]);
  final Rx<List<ReminderModel>> _currentEvents = Rx<List<ReminderModel>>([]);

  List<ReminderModel> get reminders => _reminders.value;
  List<ReminderModel> get expiredEvents => _expiredEvents.value;
  List<ReminderModel> get nextEvents => _nextEvents.value;
  List<ReminderModel> get currentEvents => _currentEvents.value;

  @override
  void onInit() async {
    super.onInit();
    await getData();
  }

  bool isValidToUpload(final ReminderModel reminder) {
    return reminder.title.isNotEmpty &&
        reminder.description.isNotEmpty &&
        reminder.endDate.isAfter(reminder.startDate);
  }

  @override
  Future<void> createData(Map<String, dynamic> data) async {
    debugPrint('Adding $data');
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    data['uid'] = uid;
    await db
        .doc(data['id'])
        .set(data)
        .then((value) async => await getData())
        .onError((error, stackTrace) => debugPrint('Failed to add'));
  }

  @override
  Future<void> deleteData(Map<String, dynamic> data) async {
    await db
        .doc(data['id'])
        .delete()
        .then((value) async => await getData())
        .onError((error, stackTrace) => debugPrint('Failed to add'));
  }

  @override
  Future<void> updateData(Map<String, dynamic> data) async {
    debugPrint('Updating $data ');
    await db
        .doc(data['id'])
        .set(data, SetOptions(merge: true))
        .then((value) async => await getData())
        .onError((error, stackTrace) => debugPrint('Failed to add'));
  }

  @override
  Future<void> getData() async {
    final resEvents = await _repo.getAllEvents();
    _reminders.value = resEvents;
    final res = await _repo.getFilteredEvents();
    _expiredEvents.value = res['Expired']!;
    _nextEvents.value = res['Next']!;
    _currentEvents.value = res['Current']!;
    isLoading.value = false;
  }

  Future<List<ReminderModel>> getRemindersPerDate(final DateTime date) async {
    return await _repo.getEventsPerDate(date);
  }
}
