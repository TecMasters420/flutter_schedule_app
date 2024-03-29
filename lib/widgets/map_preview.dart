import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:schedulemanager/data/models/event_location_model.dart';
import 'package:schedulemanager/modules/map_page/map_page.dart';
import '../app/config/enviorment.dart';
import '../domain/map_api.dart';
import '../modules/map_page/controller/map_page_controller.dart';
import 'animated_marker.dart';
import '../app/config/constants.dart';
import '../app/services/base_repository.dart';

class MapPreview extends StatefulWidget {
  final void Function(LatLng start, String? startAddress, LatLng end,
      String? endAddress, List<LatLng>? points)? onAcceptCallback;
  final EventLocationModel startLoc;
  final EventLocationModel endLoc;
  final double height;
  final double width;
  final GeoPoint initialPoint;
  final GeoPoint endPoint;
  final String? startAddress;
  final String? endAddress;

  const MapPreview({
    super.key,
    required this.height,
    required this.width,
    required this.initialPoint,
    required this.endPoint,
    required this.onAcceptCallback,
    required this.endLoc,
    required this.startLoc,
    this.startAddress,
    this.endAddress,
  });

  @override
  State<MapPreview> createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  late MapController _controller;
  late List<LatLng> _points;
  @override
  void initState() {
    super.initState();
    _controller = MapController();
    _points = [];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final start =
            LatLng(widget.initialPoint.latitude, widget.initialPoint.longitude);
        final end = LatLng(widget.endPoint.latitude, widget.endPoint.longitude);
        final points = await MapApi().getPolyline(start, end);
        if (points != null) {
          setState(() {
            _points = points;
          });
        }
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LatLng startlPos =
        LatLng(widget.initialPoint.latitude, widget.initialPoint.longitude);
    final LatLng endPos =
        LatLng(widget.endPoint.latitude, widget.endPoint.longitude);
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
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

    final theme = Theme.of(context).brightness == Brightness.dark
        ? 'dark-v11'
        : 'light-v11';

    return GestureDetector(
      child: SizedBox(
        height: widget.height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: FlutterMap(
            mapController: _controller,
            options: MapOptions(
              interactiveFlags: InteractiveFlag.none,
              enableMultiFingerGestureRace: false,
              keepAlive: false,
              // minZoom: 13,
              maxZoom: 15,
              zoom: 10,
              minZoom: 1,
              onTap: (tapPosition, point) {
                Get.put(MapPageController());
                Get.to(() => MapPage(
                      startLoc: widget.startLoc,
                      endLoc: widget.endLoc,
                    ));
              },
              center: LatLng(
                widget.initialPoint.latitude,
                widget.initialPoint.longitude,
              ),
            ),
            children: [
              TileLayer(
                backgroundColor: Colors.white,
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/mapbox/$theme/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                additionalOptions: const {
                  'styleId': 'clarc1scl000314lfyzx582dm',
                  'accessToken': Enviorment.maxboxToken,
                },
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    color: blueAccent.withOpacity(0.8),
                    borderColor: blueAccent.withOpacity(0.8),
                    borderStrokeWidth: 5,
                    strokeCap: StrokeCap.round,
                    points: _points,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [widget.initialPoint, widget.endPoint]
                    .map(
                      (e) => Marker(
                        point: LatLng(e.latitude, e.longitude),
                        builder: (context) {
                          return const AnimatedMarker();
                        },
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
