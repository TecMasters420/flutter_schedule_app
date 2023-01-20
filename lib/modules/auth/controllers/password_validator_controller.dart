import 'package:get/get.dart';
import 'package:schedulemanager/modules/auth/models/password_validator_element_model.dart';

class PasswordValidatorController extends GetxController {
  final RxList<PasswordValidatorElementModel> elements = RxList([]);

  @override
  void onInit() {
    elements.value = [
      PasswordValidatorElementModel(
        name: 'At least one upper case',
        regx: RegExp(r'(?=.*?[A-Z])'),
      ),
      PasswordValidatorElementModel(
        name: 'At least one lower case English letter',
        regx: RegExp(r'(?=.*?[a-z])'),
      ),
      PasswordValidatorElementModel(
        name: 'At least one digit',
        regx: RegExp(r'(?=.*?[0-9])'),
      ),
      PasswordValidatorElementModel(
        name: 'At least one special character',
        regx: RegExp(r'(?=.*?[#?!@$%^&*.,-])'),
      ),
      PasswordValidatorElementModel(
        name: 'At least 8 characters',
        regx: RegExp(r'.{8,}'),
      ),
    ];
    super.onInit();
  }

  void validate(final pass) {
    elements.value = elements.map((element) {
      element.isCompleted = element.regx.hasMatch(pass);
      return element;
    }).toList();
  }
}
