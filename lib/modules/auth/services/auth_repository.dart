import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:schedulemanager/modules/auth/models/api_response_model.dart';

import '../../../data/models/auth_user_model.dart';
import '../models/auth_response_model.dart';

import '../../../app/services/base_repository.dart';

class AuthRepository extends BaseRepository {
  Future<AuthResponseModel?> logIn(String email, String password) async {
    final Map<String, String> body = {
      'email': email,
      'password': password,
    };
    final res = await base.call('auth/login', body: body);
    try {
      if (res != null) {
        if (res.code == 201) {
          final Map<String, dynamic> map = jsonDecode(res.body);
          return AuthResponseModel.fromMap(map);
        }
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<AuthResponseModel?> googleLogin(String token) async {
    debugPrint('Sending JWT to API');
    final res = await base.call('auth/googleLogin', token: token);
    try {
      if (res != null) {
        return AuthResponseModel.fromMap(jsonDecode(res.body));
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<AuthUserModel?> getUserFromToken(String token) async {
    final res = await base.call('users/me', token: token);
    if (res != null) {
      if (res.code == 200) return AuthUserModel.fromMap(jsonDecode(res.body));
    }
    return null;
  }

  Future<ApiResponseModel?> register(
      AuthUserModel user, String password) async {
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
