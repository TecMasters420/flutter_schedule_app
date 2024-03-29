import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:schedulemanager/app/utils/auth_util.dart';
import 'package:schedulemanager/data/models/auth_user_model.dart';
import 'package:schedulemanager/modules/auth/models/auth_response_model.dart';
import 'package:schedulemanager/modules/push_notifications/services/push_notifications_service.dart';
import 'package:schedulemanager/routes/app_routes.dart';
import '../services/auth_repository.dart';

class AuthController extends GetxController {
  final _pushNotification = PushNotificationsService();
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  final AuthRepository _repo = AuthRepository();
  final Rx<AuthUserModel?> _currentUser = Rx(null);
  final Rx<String?> _accessToken = Rx(null);
  final Rx<String?> _fmcToken = Rx(null);
  final Rx<bool> isLoading = Rx(false);

  AuthUserModel? get currentUser => _currentUser.value;
  String? get token => _accessToken.value;
  set fmcToken(String? value) {
    _fmcToken.value = value;
  }

  @override
  void onInit() async {
    ever(_currentUser, _getPage);

    // Check jwt
    await loginWithJWTToken();
    super.onInit();
  }

  Future _getPage(AuthUserModel? user) async {
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
        if (_fmcToken.value != null) saveFMCToken();
        return true;
      }
    }
    return false;
  }

  Future<void> checkAndSaveCredentials(AuthResponseModel? authResponse) async {
    if (authResponse != null) {
      _currentUser.value = authResponse.user;
      _accessToken.value = authResponse.accessToken;
      if (_fmcToken.value != null) await saveFMCToken();
      await storage.write(key: 'token', value: _accessToken.value);
    }
  }

  Future<void> saveFMCToken() async {
    await _pushNotification.saveToken(
      _fmcToken.value!,
      _currentUser.value!.data.id,
    );
  }

  Future<void> updateFMCToken() async {
    if (_currentUser.value != null && _fmcToken.value != null) {
      _pushNotification.saveToken(
        _fmcToken.value!,
        _currentUser.value!.data.id,
      );
    }
  }

  Future<void> logIn(String email, String password) async {
    isLoading.value = true;
    final authResponse = await _repo.logIn(email, password);
    await checkAndSaveCredentials(authResponse);
    isLoading.value = false;
  }

  Future<void> googleLogin() async {
    isLoading.value = true;
    final token = await AuthUtil.googleSignIn();
    if (token != null) {
      final authResponse = await _repo.googleLogin(token);
      await checkAndSaveCredentials(authResponse);
    }
    isLoading.value = false;
  }

  Future<void> signOut() async {
    isLoading.value = true;
    Get.offNamedUntil(AppRoutes.initial, (route) => false);

    if (_fmcToken.value != null) {
      await _pushNotification.removeToken(
        _fmcToken.value!,
        _currentUser.value!.data.id,
      );
    }
    _currentUser.value = null;
    await storage.delete(key: 'token');
    _accessToken.value = null;
    isLoading.value = false;
  }

  Future<bool> register(AuthUserModel userReg, String pass) async {
    isLoading.value = true;
    final registered = await _repo.register(userReg, pass);
    isLoading.value = false;
    return registered != null;
  }
}
