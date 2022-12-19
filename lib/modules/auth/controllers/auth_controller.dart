import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:schedulemanager/data/models/user_model.dart';
import 'package:schedulemanager/modules/auth/services/auth_repository.dart';

class AuthController extends GetxController {
  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true));
  final AuthRepository _repo = AuthRepository();
  final Rx<UserModel?> _currentUser = Rx(null);
  final Rx<String?> _accessToken = Rx(null);
  Rx<bool> isLoading = Rx(false);

  UserModel? get currentUser => _currentUser.value;
  String? get token => _accessToken.value;

  @override
  void onInit() async {
    ever(_currentUser, _getPage);

    // Check jwt
    await loginWithJWTToken();
    super.onInit();
  }

  Future _getPage(UserModel? user) async {
    await Get.toNamed(user == null ? '/initialInformationPage' : '/homePage');
  }

  Future<bool> loginWithJWTToken() async {
    final savedToken = await storage.read(key: 'token');
    final tokenExist = savedToken != null;
    if (tokenExist) {
      final user = await _repo.getUserFromToken(savedToken);
      if (user != null) {
        _currentUser.value = user;
        _accessToken.value = savedToken;
        return true;
      }
    }
    return false;
  }

  Future<void> logIn(String email, String password) async {
    isLoading.value = true;

    final loggedWithJWT = await loginWithJWTToken();
    if (loggedWithJWT) return;

    final authResponse = await _repo.logIn(email, password);
    if (authResponse != null) {
      _currentUser.value = authResponse.user;
      _accessToken.value = authResponse.accessToken;
      await storage.write(key: 'token', value: _accessToken.value);
    }
    isLoading.value = false;
  }

  Future<void> signOut() async {}
}
