import 'dart:convert';
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
      return AuthResponseModel.fromMap(jsonDecode(res));
    }
    return null;
  }

  Future<UserModel?> getUserFromToken(String token) async {
    final res = await base.call('users/me', token: token);
    if (res != null) {
      return UserModel.fromMap(jsonDecode(res));
    }
    return null;
  }
}
