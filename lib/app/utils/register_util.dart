import 'package:schedulemanager/data/models/user_model.dart';

class RegisterUtil {
  static bool isValidToRegister(UserModel user, String pass) {
    return emailIsValid(user.email) &&
        passwordIsValid(pass) &&
        nameIsValid(user.name) &&
        lastNameIsValid(user.lastName);
  }

  static bool emailIsValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$').hasMatch(email);
  }

  static bool passwordIsValid(String password) {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=,.*?[#?!@$%^&*.-]).{8,}$')
        .hasMatch(password);
  }

  static bool nameIsValid(String name) {
    return name.isNotEmpty;
  }

  static bool lastNameIsValid(String lastname) {
    return lastname.isNotEmpty;
  }
}
