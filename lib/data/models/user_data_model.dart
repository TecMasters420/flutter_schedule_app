class UserDataModel {
  final String id;
  String name;
  String lastName;
  String? phone;
  String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserDataModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.createdAt,
    required this.updatedAt,
    this.imageUrl,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastName': lastName,
      'phone': phone,
      'imageUrl': imageUrl,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      id: map['id'],
      name: map['name'],
      lastName: map['lastName'],
      phone: map['phone'],
      imageUrl: map['imageUrl'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  @override
  String toString() {
    return 'UserModel(email: $lastName, createdAt: $createdAt, name: $name,)';
  }
}
