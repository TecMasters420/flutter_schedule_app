import 'dart:convert';

class InitialAnnouncementModel {
  final String title;
  final String subtitle;
  final String imageUrl;

  const InitialAnnouncementModel({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
    };
  }

  factory InitialAnnouncementModel.fromMap(Map<String, dynamic> map) {
    return InitialAnnouncementModel(
      title: map['title'],
      subtitle: map['subtitle'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());
}
