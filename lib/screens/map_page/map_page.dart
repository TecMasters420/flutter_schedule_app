import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import '../../constants/constants.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Location location = Location();

  late MapController controller;
  late final LatLng _currentLocation;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  bool _locationIsLoaded = false;

  @override
  void initState() {
    super.initState();

    controller = MapController();
    if (!kIsWeb) {
      _getLocation();
    }
  }

  void _getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      _currentLocation =
          LatLng(_locationData.latitude!, _locationData.longitude!);
      _locationIsLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: _locationIsLoaded
                  ? FlutterMap(
                      options: MapOptions(
                        enableMultiFingerGestureRace: false,
                        keepAlive: false,
                        minZoom: 3,
                        maxZoom: 18,
                        zoom: 13,
                        center: _currentLocation,
                        interactiveFlags:
                            InteractiveFlag.none | InteractiveFlag.none,
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
                              point: _currentLocation,
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
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: const [
                        CircularProgressIndicator(color: accent)
                      ],
                    ),
            ),
          ],
        ),
        // Padding(
        //   padding: const EdgeInsets.only(
        //     left: 32,
        //     right: 32,
        //     top: 50,
        //     bottom: 80,
        //   ),
        //   child: Column(
        //     children: [
        //       Flexible(
        //         child: Container(
        //           padding: const EdgeInsets.symmetric(
        //             vertical: 15,
        //             horizontal: 20,
        //           ),
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.circular(10),
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Colors.black.withOpacity(0.15),
        //                 blurRadius: 40,
        //                 offset: const Offset(0, 20),
        //               )
        //             ],
        //           ),
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               const CustomBackButton(),
        //               SizedBox(height: resp.hp(1.5)),
        //               Text(
        //                 'Title',
        //                 style: TextStyles.w500(resp.sp14, lightGrey),
        //                 textAlign: TextAlign.start,
        //                 maxLines: 2,
        //                 overflow: TextOverflow.ellipsis,
        //               ),
        //               SizedBox(height: resp.hp(0.5)),
        //               Text(
        //                 'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...',
        //                 style: TextStyles.w700(resp.sp14),
        //                 textAlign: TextAlign.start,
        //                 maxLines: 4,
        //                 overflow: TextOverflow.ellipsis,
        //               ),
        //               SizedBox(height: resp.hp(1.5)),
        //               Text(
        //                 'Location',
        //                 style: TextStyles.w500(resp.sp14, lightGrey),
        //                 textAlign: TextAlign.start,
        //                 maxLines: 2,
        //                 overflow: TextOverflow.ellipsis,
        //               ),
        //               SizedBox(height: resp.hp(0.5)),
        //               Text(
        //                 'South Portland',
        //                 style: TextStyles.w700(resp.sp14),
        //               ),
        //               SizedBox(height: resp.hp(1.5)),
        //               Text(
        //                 'Time to arrive: ',
        //                 style: TextStyles.w400(resp.sp14, grey),
        //               ),
        //               SizedBox(height: resp.hp(0.5)),
        //               Text(
        //                 '92 min',
        //                 style: TextStyles.w700(resp.sp14),
        //               ),
        //             ],
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
