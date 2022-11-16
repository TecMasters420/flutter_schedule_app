import 'package:flutter/widgets.dart';

class ActivitiesProvider with ChangeNotifier {
  late int _currentSelectedType;
  late int _remindersCount;

  int get selectedTypeIndex => _currentSelectedType;
  int get remindersCount => _remindersCount;

  ActivitiesProvider() {
    _currentSelectedType = 0;
    _remindersCount = 0;
  }

  void newActivitieTypeSelected(final int index, final int reminders) {
    _currentSelectedType = index;
    _remindersCount = reminders;
    notifyListeners();
  }
}
