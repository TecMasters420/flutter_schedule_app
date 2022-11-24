// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  String? email;
  String? password;

  final DateTime? createdAt;
  final String? displayName;
  final bool? emailVerified;
  final String? fcmToken;
  final DateTime? lastLoginAt;
  final String? phoneNumber;
  final String? imageURL;
  final String? uid;

  UserModel({
    this.createdAt,
    this.displayName,
    this.emailVerified,
    this.fcmToken,
    this.lastLoginAt,
    this.phoneNumber,
    this.imageURL,
    this.uid,
    this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'createdAt': createdAt,
      'displayName': displayName,
      'emailVerified': emailVerified,
      'fcmToken': fcmToken,
      'lastLoginAt': lastLoginAt,
      'phoneNumber': phoneNumber,
      'imageURL': imageURL,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      createdAt: map['createdAt'],
      displayName: map['displayName'],
      emailVerified: map['emailVerified'],
      fcmToken: map['fcmToken'],
      lastLoginAt: map['lastLoginAt'],
      phoneNumber: map['phoneNumber'],
      imageURL: map['imageURL'],
      uid: map['uid'],
    );
  }

  @override
  String toString() {
    return 'UserModel(email: $email, createdAt: $createdAt, displayName: $displayName, emailVerified: $emailVerified, fcmToken: $fcmToken, lastLoginAt: $lastLoginAt, phoneNumber: $phoneNumber, imageURL: $imageURL, uid: $uid)';
  }
}
