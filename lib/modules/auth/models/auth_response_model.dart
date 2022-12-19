import 'package:schedulemanager/data/models/user_model.dart';

class AuthResponseModel {
  final UserModel? user;
  final String? accessToken;

  const AuthResponseModel({
    required this.user,
    required this.accessToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'accessToken': accessToken,
    };
  }

  factory AuthResponseModel.fromMap(Map<String, dynamic> map) {
    return AuthResponseModel(
      user: UserModel.fromMap(map['user']),
      accessToken: map['access_token'],
    );
  }
}
