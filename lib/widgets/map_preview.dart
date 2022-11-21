import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:schedulemanager/constants/constants.dart';
import 'package:schedulemanager/services/base_service.dart';

class MapPreview extends StatelessWidget {
  final double height;
  final double width;
  final GeoPoint initialPoint;
  final GeoPoint endPoint;
  const MapPreview({
    super.key,
    required this.height,
    required this.width,
    required this.initialPoint,
    required this.endPoint,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'mapPage'),
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: lightGrey.withOpacity(0.25),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FlutterMap(
              options: MapOptions(
                enableMultiFingerGestureRace: false,
                keepAlive: false,
                minZoom: 3,
                maxZoom: 18,
                zoom: 13,
                center: LatLng(endPoint.latitude, endPoint.longitude),
                interactiveFlags: InteractiveFlag.none | InteractiveFlag.none,
              ),
              children: [
                TileLayer(
                  backgroundColor: Colors.white,
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/frankrdz/{styleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                  additionalOptions: {
                    'styleId': 'cl6h78sq8007q15pqr3dj6xqp',
                    'accessToken': dotenv.env['MAPBOX_ACCESSTOKEN']!,
                  },
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(
                        initialPoint.latitude,
                        initialPoint.longitude,
                      ),
                      builder: (context) {
                        return const Icon(
                          Icons.location_pin,
                          color: Colors.blue,
                        );
                      },
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
