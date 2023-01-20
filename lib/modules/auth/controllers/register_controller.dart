import 'package:get/get.dart';
import 'package:schedulemanager/data/models/user_model.dart';

class RegisterController extends GetxController {
  late final Rx<UserModel> user;
  final RxString pass = ''.obs;

  @override
  void onInit() {
    user = Rx(
      UserModel(
        id: 0,
        createdAt: DateTime.now(),
        email: '',
        lastName: '',
        name: '',
        userName: '',
      ),
    );
    super.onInit();
  }
}
