import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedulemanager/models/reminder_model.dart';

class ReminderService {
  static const String _collection = 'Reminder';

  Stream<List<Reminder>> getReminders() {
    final querySnapshot =
        FirebaseFirestore.instance.collection(_collection).snapshots();

    return querySnapshot.map(
      (query) =>
          [for (final item in query.docs) Reminder.fromJson(item.data())],
    );
  }
}
