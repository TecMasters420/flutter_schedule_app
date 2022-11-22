import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import '../models/reminder_model.dart';
import 'base_service.dart';

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
    debugPrint('Adding $data ');
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    data['uid'] = uid;
    await db
        .add(data)
        .then((value) async => getData())
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
      return;
    }
    return;
  }

  @override
  Future<void> getData() async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    _reminders = await db.where('uid', isEqualTo: uid).get().then((r) =>
        r.docs.map((e) => ReminderModel.fromMap(e.data(), e.id)).toList());
    final remindersWithoutAddress = _reminders
        .where((r) => r.endLocationAddress == null && r.endLocation != null)
        .toList();
    for (final ReminderModel r in remindersWithoutAddress) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          r.endLocation!.latitude,
          r.endLocation!.longitude,
        );
        final address =
            '${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}.';
        debugPrint('Address of ${r.title}:  \nLocation : $address');

        r.endLocationAddress = address;
        await db.doc(r.id).update(r.toMap());
      } on Exception catch (e) {
        debugPrint(
            'Error in ${r.title} ${e.toString()}:  \nLocation : ${r.endLocation}');
      }
      final String? address = await _getReminderAddress(
          LatLng(r.endLocation!.latitude, r.endLocation!.longitude));
      if (address != null) {
        r.endLocationAddress = address;
        print(address);
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
    debugPrint(
        'RemindersService Debug: \nTotal reminders: ${reminders.length} \nExpired reminders: ${expiredReminders.length} \nNot expired reminders ${_notExpiredReminders.length}');
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
