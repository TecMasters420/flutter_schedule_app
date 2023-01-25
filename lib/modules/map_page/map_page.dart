import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:schedulemanager/data/models/event_location_model.dart';
import 'package:schedulemanager/modules/map_page/controller/map_page_controller.dart';
import 'package:schedulemanager/widgets/loading_widget.dart';
import 'widgets/custom_marker_with_information.dart';
import '../../app/utils/responsive_util.dart';
import '../../app/config/constants.dart';

class MapPage extends StatelessWidget {
  final MapController _controller = MapController();
  MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final MapPageController map = Get.find();

    return Scaffold(
      body: Column(
        children: [
          Obx(
            () {
              final actualPos = map.currentLoc.value.coords;
              final actualAddress = map.currentLoc.value.address;
              final isLoading = map.isLoading.value;
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

              return !isLoading
                  ? FlutterMap(
                      mapController: _controller,
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
                          backgroundColor: Colors.white,
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
                              'Current location ${actualAddress ?? ''}':
                                  actualPos,
                              'Start Address ${startAddress ?? ''}':
                                  startCoords,
                              'End Address ${endAddress ?? ''}': endCoords,
                            }.entries.where((e) => e.value != null).map(
                              (e) {
                                return Marker(
                                  height: resp.hp(10),
                                  width: resp.wp(50),
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
                    )
                  : const LoadingWidget();
            },
          ),
        ],
      ),
    );
  }
}
