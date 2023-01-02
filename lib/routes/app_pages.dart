import 'package:get/get.dart';
import 'package:schedulemanager/modules/home/bindings/home_bindings.dart';
import 'package:schedulemanager/modules/reminders_page/bindings/events_page_bindings.dart';
import 'package:schedulemanager/modules/initial_page/bindings/initial_information_bindings.dart';
import 'package:schedulemanager/modules/home/home_page.dart';
import 'package:schedulemanager/modules/auth/pages/login_page.dart';

import '../modules/initial_page/initial_information_page.dart';
import '../modules/map_page/map_page.dart';
import '../modules/auth/pages/register_page.dart';
import '../modules/reminder_details/reminders_details_page.dart';
import '../modules/reminders_page/reminders_page.dart';
import '../modules/user_profile/user_profile_page.dart';

final List<GetPage> appPages = [
  GetPage(
    name: '/initialInformationPage',
    page: () => const InitialInformationPage(),
    binding: const InitialInformationBindings(),
  ),
  GetPage(
    name: '/loginPage',
    page: () => const LoginPage(),
  ),
  GetPage(
    name: '/homePage',
    page: () => const HomePage(),
    binding: const HomeBindings(),
  ),
  GetPage(
    name: '/registerPage',
    page: () => const RegisterPage(),
  ),
  GetPage(
    name: '/reminderDetailsPage',
    page: () => const ReminderDetailsPage(reminder: null),
  ),
  GetPage(
    name: '/remindersPage',
    page: () => const RemindersPage(),
    binding: const EventsPageBindings(),
  ),
  GetPage(
    name: '/userProfilePage',
    page: () => const UserProfilePage(),
  ),
  GetPage(
    name: '/mapPage',
    page: () => const MapPage(),
  ),
];
