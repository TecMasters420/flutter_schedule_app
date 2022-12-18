class EventLocation {
  final int id;
  final String? address;
  final double lat;
  final double lng;

  EventLocation({
    required this.id,
    required this.address,
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address,
      'Lat': lat,
      'Lng': lng,
    };
  }

  factory EventLocation.fromMap(Map<String, dynamic> map) {
    return EventLocation(
      id: map['id'],
      address: map['address'],
      lat: map['Lat'].toDouble(),
      lng: map['Lng'].toDouble(),
    );
  }
}
