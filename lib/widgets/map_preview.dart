import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:schedulemanager/constants/constants.dart';
import 'package:schedulemanager/services/base_service.dart';

class MapPreview extends StatefulWidget {
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
  State<MapPreview> createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  late MapController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MapController();
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        final LatLng startlPos =
            LatLng(widget.initialPoint.latitude, widget.initialPoint.longitude);
        final LatLng endPos =
            LatLng(widget.endPoint.latitude, widget.endPoint.longitude);
        _controller.fitBounds(
          LatLngBounds(startlPos, endPos),
          options: const FitBoundsOptions(
            padding: EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 30,
            ),
          ),
        );
      },
    );

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'mapPage'),
      child: Container(
        height: widget.height,
        width: widget.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: lightGrey.withOpacity(0.25),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FlutterMap(
              mapController: _controller,
              options: MapOptions(
                interactiveFlags: InteractiveFlag.none,
                enableMultiFingerGestureRace: false,
                keepAlive: false,
                // minZoom: 13,
                maxZoom: 15,
                zoom: 5,
                minZoom: 5,
                center: LatLng(
                  widget.initialPoint.latitude,
                  widget.initialPoint.longitude,
                ),
                onMapReady: () {},
              ),
              children: [
                PolygonLayer(
                  polygons: [
                    Polygon(
                      isFilled: true,
                      borderStrokeWidth: 10,
                      isDotted: true,
                      label: "Building",
                      points: [
                        LatLng(
                          widget.initialPoint.latitude,
                          widget.initialPoint.longitude,
                        ),
                        LatLng(
                          widget.endPoint.latitude,
                          widget.endPoint.longitude,
                        )
                      ],
                      color: Colors.red,
                      borderColor: Colors.green,
                    )
                  ],
                ),
                TileLayer(
                  backgroundColor: Colors.white,
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/frankrdz/clarc1scl000314lfyzx582dm/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                  additionalOptions: {
                    'styleId': 'cl6h78sq8007q15pqr3dj6xqp',
                    'accessToken': dotenv.env['MAPBOX_ACCESSTOKEN']!,
                  },
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(
                        widget.initialPoint.latitude,
                        widget.initialPoint.longitude,
                      ),
                      builder: (context) {
                        return const Icon(
                          Icons.location_pin,
                          color: Colors.blue,
                        );
                      },
                    ),
                    Marker(
                      point: LatLng(
                        widget.endPoint.latitude,
                        widget.endPoint.longitude,
                      ),
                      builder: (context) {
                        return const Icon(
                          Icons.location_pin,
                          color: Colors.blue,
                        );
                      },
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
