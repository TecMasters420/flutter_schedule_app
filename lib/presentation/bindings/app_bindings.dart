import 'package:get/get.dart';
import 'package:schedulemanager/presentation/bindings/auth_bindings.dart';
import 'package:schedulemanager/presentation/bindings/initial_information_bindings.dart';
import 'package:schedulemanager/presentation/bindings/reminders_bindings.dart';

class AppBindings implements Bindings {
  const AppBindings();
  @override
  void dependencies() {
    const InitialInformationBindings().dependencies();
    const AuthBindings().dependencies();
    const RemindersBindings().dependencies();
  }
}
