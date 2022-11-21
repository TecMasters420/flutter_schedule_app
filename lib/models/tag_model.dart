class TagModel {
  final String name;
  TagModel({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory TagModel.fromMap(Map<String, dynamic> map) {
    return TagModel(
      name: map['name'] as String,
    );
  }
}
