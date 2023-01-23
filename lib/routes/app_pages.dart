import 'package:get/get.dart';
import 'package:schedulemanager/modules/auth/bindings/register_bindings.dart';
import 'package:schedulemanager/modules/event_details_creation/new_events_details_creation_page.dart';
import 'package:schedulemanager/modules/filtered_events/pages/filtered_events_page.dart';
import 'package:schedulemanager/modules/notifications_page/pages/notifications_page.dart';
import 'package:schedulemanager/modules/event_details_creation/bindings/events_details_creation_bindings.dart';
import 'package:schedulemanager/routes/app_routes.dart';
import '../modules/home/bindings/home_bindings.dart';
import '../modules/reminders_page/bindings/events_page_bindings.dart';
import '../modules/initial_page/bindings/initial_information_bindings.dart';
import '../modules/home/home_page.dart';
import '../modules/auth/pages/login_page.dart';

import '../modules/initial_page/initial_information_page.dart';
import '../modules/map_page/map_page.dart';
import '../modules/auth/pages/register_page.dart';
import '../modules/event_details_creation/reminders_details_page.dart';
import '../modules/reminders_page/events_page.dart';
import '../modules/user_profile/user_profile_page.dart';

final List<GetPage> appPages = [
  GetPage(
    name: AppRoutes.initial,
    page: () => const InitialInformationPage(),
    binding: const InitialInformationBindings(),
  ),
  GetPage(
    name: AppRoutes.filteredEvents,
    page: () => const FilteredEventsPage(events: [], title: ''),
  ),
  GetPage(
    name: AppRoutes.login,
    page: () => LoginPage(),
  ),
  GetPage(
    name: AppRoutes.home,
    page: () => const HomePage(),
    binding: const HomeBindings(),
  ),
  GetPage(
    name: AppRoutes.register,
    binding: const RegisterBindings(),
    page: () => const RegisterPage(),
  ),
  GetPage(
    name: AppRoutes.eventDetails,
    page: () => const NewEventsDetailsCreationPage(),
    binding: const EventsDetailsCreationBindings(),
  ),
  GetPage(
    name: AppRoutes.events,
    page: () => const EventsPage(),
    binding: const EventsPageBindings(),
  ),
  GetPage(
    name: AppRoutes.profile,
    page: () => const UserProfilePage(),
  ),
  GetPage(
    name: AppRoutes.mapPage,
    page: () => const MapPage(),
  ),
  GetPage(
    name: AppRoutes.notifications,
    page: () => const NotificationsPage(),
  ),
];
