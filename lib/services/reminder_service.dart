import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:schedulemanager/models/reminder_model.dart';
import 'package:schedulemanager/services/base_service.dart';

class ReminderService extends BaseService with ChangeNotifier {
  static const String _collection = 'Reminder';

  final db = FirebaseFirestore.instance.collection(_collection);
  List<ReminderModel> _reminders = [];
  List<ReminderModel> _expiredReminders = [];
  List<ReminderModel> _notExpiredReminders = [];

  List<ReminderModel> get reminders => _reminders;
  List<ReminderModel> get expiredReminders => _expiredReminders;
  List<ReminderModel> get notExpiredReminders => _notExpiredReminders;

  @override
  Future<void> create(Map<String, dynamic> data) async {
    await db
        .add(data)
        .then((value) async => getData())
        .onError((error, stackTrace) => print('Failed to add'));
  }

  @override
  Future<void> delete(Map<String, dynamic> data) async {}

  @override
  Future<void> update(Map<String, dynamic> data) async {}

  @override
  Future<void> getData() async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    _reminders = await FirebaseFirestore.instance
        .collection(_collection)
        .where('uid', isEqualTo: uid)
        .get()
        .then(
            (r) => r.docs.map((e) => ReminderModel.fromMap(e.data())).toList());

    // Get expired reminders
    _expiredReminders = _reminders
        .where((reminder) => reminder.endDate.toDate().isBefore(DateTime.now()))
        .toList();

    // Get not expired reminders
    _notExpiredReminders = reminders.where((reminder) {
      final endDate = reminder.endDate.toDate();
      final isAfter = endDate.isAfter(DateTime.now());
      return isAfter;
    }).toList();
    debugPrint(
        'RemindersService Debug: \nTotal reminders: ${reminders.length} \nExpired reminders: ${expiredReminders.length} \nNot expired reminders ${_notExpiredReminders.length}');
    notifyListeners();
  }

  List<ReminderModel> getRemindersPerDate(final DateTime date) {
    return reminders.where((e) {
      final remDate = e.endDate.toDate();
      final roundDate = DateTime(remDate.year, remDate.month, remDate.day);
      return roundDate.difference(date).inDays == 0;
    }).toList();
  }
}
