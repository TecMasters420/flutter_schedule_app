import 'package:schedulemanager/data/models/auth_user_model.dart';

class RegisterUtil {
  static bool isValidToRegister(AuthUserModel user, String pass) {
    return emailIsValid(user.email) &&
        passwordIsValid(pass) &&
        nameIsValid(user.data.name) &&
        lastNameIsValid(user.data.lastName);
  }

  static bool emailIsValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  static bool passwordIsValid(String password) {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!.,@$%^&*-]).{8,}$')
        .hasMatch(password);
  }

  static bool nameIsValid(String name) {
    return name.isNotEmpty;
  }

  static bool lastNameIsValid(String lastname) {
    return lastname.isNotEmpty;
  }
}
