import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import '../models/reminder_model.dart';
import 'base_service.dart';
import 'package:uuid/uuid.dart';

class ReminderService extends BaseService with ChangeNotifier {
  static const String _collection = 'Reminder';

  final db = FirebaseFirestore.instance.collection(_collection);
  List<ReminderModel> _reminders = [];
  List<ReminderModel> _expiredReminders = [];
  List<ReminderModel> _notExpiredReminders = [];

  List<ReminderModel> get reminders => _reminders;
  List<ReminderModel> get expiredReminders => _expiredReminders;
  List<ReminderModel> get notExpiredReminders => _notExpiredReminders;

  bool isValidToUpload(final ReminderModel reminder) {
    return reminder.title.isNotEmpty && reminder.description.isNotEmpty;
  }

  @override
  Future<void> create(Map<String, dynamic> data) async {
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
  Future<void> delete(Map<String, dynamic> data) async {}

  @override
  Future<void> update(Map<String, dynamic> data, [final String id = '']) async {
    debugPrint('Updating $data ');
    if (id.isNotEmpty) {
      await db.doc(id).update(data);
      await getData();
    }
  }

  @override
  Future<void> getData([VoidCallback? onChangesCallback]) async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    _reminders = await db.where('uid', isEqualTo: uid).get().then(
        (r) => r.docs.map((e) => ReminderModel.fromMap(e.data())).toList());
    final remindersWithoutAddress = _reminders
        .where((r) =>
            r.endLocationAddress == null && r.endLocation != null ||
            r.startLocationAddress == null && r.startLocation != null)
        .toList();
    for (final ReminderModel r in remindersWithoutAddress) {
      try {
        List<Placemark> endMarks = await placemarkFromCoordinates(
          r.endLocation!.latitude,
          r.endLocation!.longitude,
        );
        List<Placemark> startMarks = await placemarkFromCoordinates(
          r.startLocation!.latitude,
          r.startLocation!.longitude,
        );
        final endAddress =
            '${endMarks[0].street}, ${endMarks[0].locality}, ${endMarks[0].administrativeArea}.';
        final String startAddress =
            '${startMarks[0].street}, ${startMarks[0].locality}, ${startMarks[0].administrativeArea}.';

        r.endLocationAddress = endAddress;
        r.startLocationAddress = startAddress;
        await db.doc(r.id).update(r.toMap());
      } on Exception catch (e) {
        debugPrint(
            'Error in ${r.title} ${e.toString()}:  \nLocation : ${r.endLocation}');
      }
      final String? address = await _getReminderAddress(
          LatLng(r.endLocation!.latitude, r.endLocation!.longitude));
      if (address != null) {
        r.endLocationAddress = address;
        // debugPrint(address);
        await db.doc(r.id).update(r.toMap());
      }
    }

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
    // debugPrint(
    //     'RemindersService Debug: \nTotal reminders: ${reminders.length} \nExpired reminders: ${expiredReminders.length} \nNot expired reminders ${_notExpiredReminders.length}');
    notifyListeners();
  }

  Future<String?> _getReminderAddress(final LatLng coords) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        coords.latitude,
        coords.longitude,
      );
      return '${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}.';
    } on Exception catch (e) {
      debugPrint('Error $e');
      return null;
    }
  }

  List<ReminderModel> getRemindersPerDate(final DateTime date) {
    return reminders.where((e) {
      final remDate = e.endDate.toDate();
      final roundDate = DateTime(remDate.year, remDate.month, remDate.day);
      return roundDate.difference(date).inDays == 0;
    }).toList();
  }
}
