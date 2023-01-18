import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/modules/navbar/models/navbar_element_model.dart';

class NavBarController extends GetxController {
  final RxList<NavBarElementModel> elements = RxList([]);
  Rx<NavBarElementModel?> currentElement = null.obs;

  @override
  void onInit() {
    super.onInit();
    elements.value = [
      NavBarElementModel(name: 'Home', route: 'homePage', icon: Icons.home),
      NavBarElementModel(
        name: 'Notifications',
        route: 'notificationsPage',
        icon: Icons.notifications,
      ),
      NavBarElementModel(
        name: 'Events',
        route: 'eventsPage',
        icon: Icons.calendar_month,
      ),
      NavBarElementModel(
        name: 'Profile',
        route: 'profilePage',
        icon: Icons.supervised_user_circle_rounded,
      ),
    ];
    currentElement = Rx<NavBarElementModel>(elements.first);
  }

  void onNewSelection(NavBarElementModel element) {
    currentElement.value = element;
  }
}
