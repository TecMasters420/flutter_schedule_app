import 'package:get/get.dart';
import 'package:schedulemanager/data/models/user_data_model.dart';

import '../../../data/models/auth_user_model.dart';

class RegisterController extends GetxController {
  late final Rx<AuthUserModel> user;
  final RxString pass = ''.obs;

  @override
  void onInit() {
    user = Rx(
      AuthUserModel(
        id: '',
        email: '',
        registerType: 'Normal',
        data: UserDataModel(
          createdAt: DateTime.now(),
          id: '',
          name: '',
          lastName: '',
          updatedAt: DateTime.now(),
        ),
      ),
    );
    super.onInit();
  }
}
