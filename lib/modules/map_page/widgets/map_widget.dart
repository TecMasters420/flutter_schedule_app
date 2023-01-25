import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';
import 'package:schedulemanager/modules/map_page/controller/map_page_controller.dart';

import '../../../app/config/constants.dart';
import '../../../data/models/event_location_model.dart';
import 'custom_marker_with_information.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MapPageController map = Get.find();
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
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
              options: MapOptions(
                enableMultiFingerGestureRace: false,
                keepAlive: false,
                minZoom: 10,
                maxZoom: 18,
                zoom: 13,
                center: map.currentLoc.value.coords,
                onLongPress: (tapPosition, point) {},
              ),
              children: [
                TileLayer(
                  backgroundColor: containerBg,
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/frankrdz/{styleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                  additionalOptions: {
                    'styleId': 'clarc1scl000314lfyzx582dm',
                    'accessToken': dotenv.env['MAPBOX_ACCESSTOKEN']!,
                  },
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      color: accent.withOpacity(0.8),
                      borderColor: accent.withOpacity(0.8),
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
                        color: accent,
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
                        color: accent,
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
