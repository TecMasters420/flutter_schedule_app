import 'dart:convert';
import 'package:schedulemanager/modules/auth/models/api_response_model.dart';

import '../../../data/models/user_model.dart';
import '../models/auth_response_model.dart';

import '../../../app/services/base_repository.dart';

class AuthRepository extends BaseRepository {
  Future<AuthResponseModel?> logIn(String email, String password) async {
    final Map<String, String> body = {
      'username': email,
      'password': password,
    };
    final res = await base.call('auth/login', body: body);
    if (res != null) {
      return AuthResponseModel.fromMap(jsonDecode(res.body));
    }
    return null;
  }

  Future<UserModel?> getUserFromToken(String token) async {
    final res = await base.call('users/me', token: token);
    if (res != null) {
      return UserModel.fromMap(jsonDecode(res.body));
    }
    return null;
  }

  Future<ApiResponseModel?> register(UserModel user, String password) async {
    final Map<String, dynamic> body = user.toMap();
    body.addAll({'password': password, "confirmation_password": password});
    final res = await base.call('users', body: body);
    return res == null
        ? null
        : res.code == 400
            ? null
            : res;
  }
}
