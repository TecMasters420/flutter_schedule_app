import 'package:schedulemanager/data/models/user_data_model.dart';

class AuthUserModel {
  final String id;
  final String registerType;
  final UserDataModel data;
  String email;
  String? password;
  AuthUserModel({
    required this.id,
    required this.email,
    required this.registerType,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'registerType': registerType,
      'data': data.toMap(),
      'password': password,
    };
  }

  factory AuthUserModel.fromMap(Map<String, dynamic> map) {
    return AuthUserModel(
      id: map['id'],
      email: map['email'],
      registerType: map['registerType'],
      data: UserDataModel.fromMap(map['data']),
    );
  }
}
