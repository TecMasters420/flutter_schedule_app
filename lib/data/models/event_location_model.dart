import 'package:latlong2/latlong.dart';

class EventLocationModel {
  final int id;
  final String? address;
  final double lat;
  final double lng;

  EventLocationModel({
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

  LatLng get coords => LatLng(lat, lng);

  factory EventLocationModel.fromMap(Map<String, dynamic> map) {
    return EventLocationModel(
      id: map['id'],
      address: map['address'],
      lat: map['Lat'].toDouble(),
      lng: map['Lng'].toDouble(),
    );
  }

  factory EventLocationModel.empty() {
    return EventLocationModel(id: 0, address: '', lat: 0, lng: 0);
  }
}
