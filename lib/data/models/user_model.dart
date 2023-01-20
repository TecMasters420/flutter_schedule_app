class UserModel {
  final int id;
  String name;
  String lastName;
  String userName;
  String? phone;
  String email;
  String? imageUrl;
  DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.createdAt,
    this.imageUrl,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lastName': lastName,
      'userName': userName,
      'phone': phone,
      'email': email,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      lastName: map['lastName'],
      userName: map['username'],
      phone: map['phone'],
      email: map['email'],
      imageUrl: map['imageUrl'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  @override
  String toString() {
    return 'UserModel(email: $email, createdAt: $createdAt, name: $name,)';
  }
}
