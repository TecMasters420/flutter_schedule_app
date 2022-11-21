class TaskModel {
  String name;
  bool isCompleted;
  TaskModel({
    required this.name,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      name: map['name'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  @override
  String toString() => 'TaskModel(name: $name, isCompleted: $isCompleted)';

  List<Object?> get props => [];
}
