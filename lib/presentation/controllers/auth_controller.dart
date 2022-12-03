import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/presentation/pages/home_page/home_page.dart';
import 'package:schedulemanager/presentation/pages/initial_page/initial_information_page.dart';

class AuthController extends GetxController {
  // static AuthController instance = Get.find();
  // late Rx<User?> _user;
  // FirebaseAuth auth = FirebaseAuth.instance;

  // @override
  // void onReady() {
  //   super.onReady();
  //   _user = Rx<User?>(auth.currentUser);
  //   _user.bindStream(auth.userChanges());

  //   ever(_user, _initialScreen);
  // }

  // _initialScreen(User? user) {
  //   Get.offAll(
  //     user == null ? const InitialInformationPage() : const HomePage(),
  //   );
  // }

  // void logOut() async {
  //   await auth.signOut();
  // }
}
