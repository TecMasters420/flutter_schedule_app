import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:schedulemanager/app/config/enviorment.dart';
import 'package:schedulemanager/data/models/event_location_model.dart';

class MapApi with ChangeNotifier {
  static const String _apiURL = 'https://api.mapbox.com';
  static const String _apiVer = 'v5/mapbox';

  static const String _places = '$_apiURL/geocoding/$_apiVer.places/';
  static const String _directions = '$_apiURL/directions/$_apiVer/driving';

  static const String _jsonLimit = '.json?limit';
  final String _accessToken = 'access_token=${Enviorment.maxboxToken}';

  String _lastQuery = '';
  List<EventLocationModel> _address = [];
  List<EventLocationModel> get address => _address;

  Future<Map<String, dynamic>?> _baseRequest(final String url) async {
    try {
      debugPrint(url);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) return jsonDecode(response.body);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<String?> getAddress(final LatLng coords) async {
    try {
      final res = await _baseRequest(
          '$_places${coords.longitude},${coords.latitude}$_jsonLimit=1&$_accessToken');
      if (res == null) return null;
      return res['features'][0]['place_name'];
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<List<LatLng>?> getPolyline(
      final LatLng startCoords, final LatLng finalCoords) async {
    try {
      final res = await _baseRequest(
          '$_directions/${startCoords.longitude},${startCoords.latitude};${finalCoords.longitude},${finalCoords.latitude}?geometries=geojson&$_accessToken');
      if (res == null) return null;
      final List<dynamic> coordinatesList =
          res['routes'][0]['geometry']['coordinates'];
      final coords = coordinatesList.map((e) => LatLng(e[1], e[0])).toList();
      return coords;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<List<EventLocationModel>?> getNearbyDirections(
      final String query) async {
    if (_lastQuery == query) return [];
    try {
      final res = await _baseRequest(
          '$_places/${query.replaceAll(' ', '%20')}$_jsonLimit&proximity=ip&$_accessToken');
      if (res == null) return null;
      final List<dynamic>? features = res['features'];
      _address = features!
          .map((e) => EventLocationModel(
              id: -1,
              address: e['place_name'],
              lat: e['center'][1].toDouble(),
              lng: e['center'][0].toDouble()))
          .toList();
      _lastQuery = query;
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
