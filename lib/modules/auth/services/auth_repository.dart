import 'dart:convert';
import 'package:schedulemanager/common/request_base.dart';
import 'package:schedulemanager/modules/auth/models/auth_response_model.dart';

class AuthRepository {
  final RequestBase base = RequestBase();

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
}
