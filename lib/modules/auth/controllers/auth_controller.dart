import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:schedulemanager/app/utils/auth_util.dart';
import 'package:schedulemanager/routes/app_routes.dart';
import '../../../data/models/user_model.dart';
import '../services/auth_repository.dart';

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
    Get.offNamedUntil(
        user == null ? AppRoutes.initial : AppRoutes.home, (route) => false);
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

    final authResponse = await _repo.logIn(email, password);
    if (authResponse != null) {
      _currentUser.value = authResponse.user;
      _accessToken.value = authResponse.accessToken;
      await storage.write(key: 'token', value: _accessToken.value);
    }
    isLoading.value = false;
  }

  Future<void> googleLogin() async {
    isLoading.value = true;
    await AuthUtil.googleSignIn();
    isLoading.value = false;
  }

  Future<void> signOut() async {
    isLoading.value = true;
    Get.offNamedUntil(AppRoutes.initial, (route) => false);

    _currentUser.value = null;
    await storage.delete(key: 'token');
    _accessToken.value = null;
    isLoading.value = false;
  }

  Future<bool> register(UserModel userReg, String pass) async {
    isLoading.value = true;
    final registered = await _repo.register(userReg, pass);
    isLoading.value = false;
    return registered != null;
  }
}
