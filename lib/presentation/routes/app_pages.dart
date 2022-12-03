import 'package:get/get.dart';
import 'package:schedulemanager/presentation/bindings/auth_bindings.dart';
import 'package:schedulemanager/presentation/bindings/initial_information_bindings.dart';
import 'package:schedulemanager/presentation/pages/home_page/home_page.dart';
import 'package:schedulemanager/presentation/pages/login_page/login_page.dart';

import '../pages/initial_page/initial_information_page.dart';
import '../pages/map_page/map_page.dart';
import '../pages/register_page/register_page.dart';
import '../pages/reminder_details_page/reminders_details_page.dart';
import '../pages/reminders_page/reminders_page.dart';
import '../pages/user_profile_page/user_profile_page.dart';

final List<GetPage> appPages = [
  GetPage(
    name: '/initialInformationPage',
    page: () => const InitialInformationPage(),
    binding: const InitialInformationBindings(),
  ),
  GetPage(
    name: '/loginPage',
    page: () => const LoginPage(),
    binding: const AuthBindings(),
  ),
  GetPage(
    name: '/homePage',
    page: () => const HomePage(),
    binding: const AuthBindings(),
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
