import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:schedulemanager/app/config/app_constants.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';
import 'package:schedulemanager/modules/map_page/controller/map_page_controller.dart';

import '../../../app/config/constants.dart';
import '../../../data/models/event_location_model.dart';
import 'custom_marker_with_information.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late final MapController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MapController();
  }

  @override
  Widget build(BuildContext context) {
    final MapPageController map = Get.find();
    map.getPoints();
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        final start = map.startLoc.value;
        final end = map.endLoc.value;
        if (start != null && end != null) {
          _controller.fitBounds(
            LatLngBounds(start.coords, end.coords),
            options: const FitBoundsOptions(
              padding: EdgeInsets.symmetric(
                vertical: 100,
                horizontal: 100,
              ),
            ),
          );
        }
      },
    );

    return Obx(
      () {
        final actualPos = map.currentLoc.value.coords;
        final actualAddress = map.currentLoc.value.address;
        EventLocationModel? startLoc;
        LatLng? startCoords;
        String? startAddress;
        EventLocationModel? endLoc;
        LatLng? endCoords;
        String? endAddress;
        if (map.endLoc.value != null) {
          endLoc = map.endLoc.value;
          endCoords = endLoc!.coords;
          endAddress = endLoc.address;
        }
        if (map.startLoc.value != null) {
          startLoc = map.startLoc.value;
          startCoords = startLoc!.coords;
          startAddress = startLoc.address;
        }

        return Stack(
          children: [
            FlutterMap(
              mapController: _controller,
              options: MapOptions(
                enableMultiFingerGestureRace: false,
                keepAlive: false,
                minZoom: 5,
                maxZoom: 18,
                zoom: 13,
                center: startCoords ?? map.currentLoc.value.coords,
                onLongPress: (tapPosition, point) {},
              ),
              children: [
                TileLayer(
                  backgroundColor: containerBg,
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/frankrdz/{styleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                  additionalOptions: {
                    'styleId': AppConstants.mapStyleId,
                    'accessToken': dotenv.env['MAPBOX_ACCESSTOKEN']!,
                  },
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      color: blueAccent.withOpacity(0.8),
                      borderColor: blueAccent.withOpacity(0.8),
                      borderStrokeWidth: 5,
                      strokeCap: StrokeCap.round,
                      points: map.points,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    ...{
                      'Current location ${actualAddress ?? ''}': actualPos,
                      'Start Address ${startAddress ?? ''}': startCoords,
                      'End Address ${endAddress ?? ''}': endCoords,
                    }.entries.where((e) => e.value != null).map(
                      (e) {
                        return Marker(
                          height: resp.hp(20),
                          width: resp.wp(80),
                          point: e.value as LatLng,
                          builder: (context) {
                            return CustomMarkerWithInformation(
                              label: e.key,
                            );
                          },
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.all(12.5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: blueAccent,
                      ),
                      child: const Icon(
                        Icons.location_searching_rounded,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.all(12.5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: blueAccent,
                      ),
                      child: const Icon(
                        Icons.search,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
