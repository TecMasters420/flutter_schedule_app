class InitialAnnouncementModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  const InitialAnnouncementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory InitialAnnouncementModel.fromMap(Map<String, dynamic> map) {
    return InitialAnnouncementModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
