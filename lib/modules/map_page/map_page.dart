import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../../domain/map_api.dart';
import '../../data/models/address_model.dart';
import 'widgets/custom_marker_with_information.dart';
import '../../app/utils/responsive_util.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/custom_button.dart';

import '../../app/config/constants.dart';
import '../../app/utils/text_styles.dart';

class MapPage extends StatefulWidget {
  final LatLng? startPos;
  final LatLng? endPost;
  final String? startAddress;
  final String? endAddress;
  final void Function(LatLng start, String? startAddress, LatLng end,
      String? endAddress, List<LatLng>? points)? onAcceptCallback;
  const MapPage({
    super.key,
    this.onAcceptCallback,
    this.startPos,
    this.endPost,
    this.startAddress,
    this.endAddress,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late LatLng? _startPos;
  late LatLng? _endPos;
  late List<LatLng>? _points;

  late String? _startAddress;
  late String? _endAddress;
  late String? _currentAddress;

  final Location location = Location();
  late final MapController _controller;

  late LatLng _currentLocation;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  bool _locationIsLoaded = false;

  @override
  void initState() {
    super.initState();
    _startPos = widget.startPos;
    _endPos = widget.endPost;
    _points = [];
    _startAddress = widget.startAddress;
    _endAddress = widget.endAddress;
    _controller = MapController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_startPos != null && _endPos != null) {
        final points = await MapApi().getPolyline(_startPos!, _endPos!);
        _points = points;
      }
      if (!kIsWeb) {
        _getLocation();
      }
    });
  }

  Future<void> _getLocation() async {
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
    final LatLng coords =
        LatLng(_locationData.latitude!, _locationData.longitude!);
    final String? address = await MapApi().getAddress(coords);
    setState(() {
      _currentLocation = coords;
      _currentAddress = address;
      _locationIsLoaded = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final MapApi api = Provider.of<MapApi>(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                child: _locationIsLoaded
                    ? FlutterMap(
                        mapController: _controller,
                        options: MapOptions(
                          enableMultiFingerGestureRace: false,
                          keepAlive: false,
                          minZoom: 10,
                          maxZoom: 18,
                          zoom: 13,
                          center: _currentLocation,
                          onLongPress: (tapPosition, point) {
                            CustomAlertDialog(
                              resp: resp,
                              context: context,
                              title: 'Set point in:',
                              showButtons: false,
                              onAcceptCallback: () {},
                              customBody: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: CustomButton(
                                      text: 'Start point',
                                      color: accent,
                                      height: resp.hp(5),
                                      width: resp.width,
                                      style: TextStyles.w600(14, Colors.white),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        final String? address =
                                            await api.getAddress(point);
                                        setState(() {
                                          _startAddress = address;
                                          _startPos = point;
                                        });
                                        if (_endPos != null &&
                                            _startPos != null) {
                                          final points = await api.getPolyline(
                                              _startPos!, _endPos!);
                                          setState(() {
                                            _points = points;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(height: resp.hp(1)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: CustomButton(
                                      text: 'End point',
                                      color: lightGrey.withOpacity(0.25),
                                      height: resp.hp(5),
                                      width: resp.width,
                                      style: TextStyles.w600(14),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        final String? address =
                                            await MapApi().getAddress(point);
                                        setState(() {
                                          _endAddress = address;
                                          _endPos = point;
                                        });
                                        if (_endPos != null &&
                                            _startPos != null) {
                                          final points = await api.getPolyline(
                                              _startPos!, _endPos!);
                                          setState(() {
                                            _points = points;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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
                                strokeCap: StrokeCap.square,
                                points: _points ?? [],
                              ),
                            ],
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                height: resp.hp(10),
                                width: resp.wp(50),
                                point: _currentLocation,
                                builder: (context) {
                                  return const CustomMarkerWithInformation(
                                    label: 'Current location',
                                  );
                                },
                              ),
                              if (_startPos != null)
                                Marker(
                                  height: resp.hp(10),
                                  width: resp.wp(80),
                                  point: _startPos!,
                                  builder: (context) {
                                    return CustomMarkerWithInformation(
                                      label:
                                          'Start Address ${_startAddress ?? ''}',
                                    );
                                  },
                                ),
                              if (_endPos != null)
                                Marker(
                                  height: resp.hp(10),
                                  width: resp.wp(80),
                                  point: _endPos!,
                                  builder: (context) {
                                    return CustomMarkerWithInformation(
                                      label: 'End Address ${_endAddress ?? ''}',
                                    );
                                  },
                                ),
                            ],
                          )
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(color: accent)),
              ),
            ],
          ),
          Positioned(
            top: resp.hp(83),
            child: Column(
              children: [
                CustomButton(
                  text: 'Search locations',
                  color: Colors.white,
                  height: resp.hp(7),
                  width: resp.wp(80),
                  style: TextStyles.w700(16, accent),
                  onTap: () {
                    CustomAlertDialog(
                      resp: resp,
                      context: context,
                      title: 'Set locations',
                      showButtons: false,
                      onAcceptCallback: () {},
                      customBody: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              'Select Start position:',
                              style: TextStyles.w500(16),
                            ),
                          ),
                          SizedBox(height: resp.hp(1)),
                          Row(
                            children: [
                              CustomButton(
                                text: 'Current location',
                                color: accent,
                                height: resp.hp(5),
                                width: resp.wp(35),
                                style: TextStyles.w600(14, Colors.white),
                                onTap: () async {
                                  Navigator.pop(context);
                                  List<LatLng>? points;
                                  if (_endPos != null && _startPos != null) {
                                    points = await api.getPolyline(
                                        _currentLocation, _endPos!);
                                  }
                                  setState(() {
                                    _startPos = _currentLocation;
                                    _startAddress = _currentAddress;
                                    _points = points;
                                  });
                                },
                              ),
                              SizedBox(width: resp.wp(2.5)),
                              CustomButton(
                                text: 'Search',
                                color: lightGrey.withOpacity(0.25),
                                height: resp.hp(5),
                                width: resp.wp(25),
                                style: TextStyles.w600(14, accent),
                                onTap: () async {
                                  final res = await showSearch(
                                    context: context,
                                    delegate: MySearchDelegate(),
                                  );
                                  if (res == null) return;
                                  final a = res as AddressModel;
                                  _startPos = LatLng(a.latitude, a.longitud);
                                  final points = await api.getPolyline(
                                      _startPos!, _endPos!);
                                  setState(() {
                                    _startAddress = a.address;
                                    _points = points;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: resp.hp(2)),
                          Flexible(
                            child: Text(
                              'Select End position:',
                              style: TextStyles.w500(16),
                            ),
                          ),
                          SizedBox(height: resp.hp(1)),
                          Row(
                            children: [
                              CustomButton(
                                text: 'Current location',
                                color: accent,
                                height: resp.hp(5),
                                width: resp.wp(35),
                                style: TextStyles.w600(14, Colors.white),
                                onTap: () async {
                                  Navigator.pop(context);
                                  List<LatLng>? points;
                                  if (_startPos != null && _endPos != null) {
                                    points = await api.getPolyline(
                                        _startPos!, _currentLocation);
                                  }
                                  setState(() {
                                    _points = points;
                                    _endAddress = _currentAddress;
                                    _endPos = _currentLocation;
                                  });
                                },
                              ),
                              SizedBox(width: resp.wp(2.5)),
                              CustomButton(
                                text: 'Search',
                                color: lightGrey.withOpacity(0.25),
                                height: resp.hp(5),
                                width: resp.wp(25),
                                style: TextStyles.w600(14, accent),
                                onTap: () async {
                                  final res = await showSearch(
                                    context: context,
                                    delegate: MySearchDelegate(),
                                  );
                                  if (res == null) return;
                                  final a = res as AddressModel;
                                  _endPos = LatLng(a.latitude, a.longitud);
                                  final points = await api.getPolyline(
                                      _startPos!, _endPos!);
                                  setState(() {
                                    _endAddress = a.address;
                                    _points = points;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: resp.hp(1)),
                CustomButton(
                  text: 'Accept locations',
                  color: accent,
                  height: resp.hp(7),
                  width: resp.wp(80),
                  style: TextStyles.w700(16, Colors.white),
                  onTap: () {
                    if (_endPos != null && _startPos != null) {
                      if (widget.onAcceptCallback != null) {
                        widget.onAcceptCallback!(_startPos!, _startAddress!,
                            _endPos!, _endAddress!, _points);
                        Navigator.pop(context);
                      }
                    } else {
                      CustomAlertDialog(
                        resp: resp,
                        dismissible: true,
                        context: context,
                        onAcceptCallback: () {},
                        showButtons: false,
                        title: 'Error: check the data!',
                        customBody: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.block_rounded,
                                color: Colors.red[200], size: 45),
                            SizedBox(height: resp.hp(2)),
                            Text('You must enter a location.',
                                style: TextStyles.w500(16))
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final MapApi api = Provider.of<MapApi>(context);
    return Scaffold(
        body: ListView.builder(
      itemCount: api.address.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => close(context, []),
          title: Text(
            api.address[index].address,
            style: TextStyles.w500(12),
          ),
        );
      },
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final MapApi api = Provider.of<MapApi>(context);
    api.getNearbyDirections(query);
    return ListView.builder(
      itemCount: api.address.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => close(context, api.address[index]),
          title: Text(
            api.address[index].address,
            style: TextStyles.w500(12),
          ),
        );
      },
    );
  }
}
