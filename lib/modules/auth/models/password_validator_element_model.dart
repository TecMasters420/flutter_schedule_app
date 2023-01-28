class PasswordValidatorElementModel {
  final String name;
  final RegExp regx;
  bool isCompleted;
  PasswordValidatorElementModel({
    required this.name,
    required this.regx,
    this.isCompleted = false,
  });
}
