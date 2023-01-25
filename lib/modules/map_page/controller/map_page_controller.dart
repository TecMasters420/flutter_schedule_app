import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:schedulemanager/data/models/event_location_model.dart';

import '../../../domain/map_api.dart';

class MapPageController extends GetxController {
  final RxBool isLoading = RxBool(false);
  final Rx<EventLocationModel?> startLoc = Rx(null);
  final Rx<EventLocationModel?> endLoc = Rx(null);
  final Rx<EventLocationModel> currentLoc = Rx(EventLocationModel.empty());
  final RxList<LatLng> points = RxList([]);

  @override
  void onInit() async {
    super.onInit();
    await getUserLocation();
  }

  Future<void> getUserLocation() async {
    isLoading.value = true;
    final location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissions = await location.hasPermission();
    if (permissions == PermissionStatus.denied) {
      permissions = await location.requestPermission();
      if (permissions != PermissionStatus.granted) return;
    }

    final userLocation = await location.getLocation();
    final coords = LatLng(userLocation.latitude!, userLocation.longitude!);
    final String? address = await MapApi().getAddress(coords);
    currentLoc.value = EventLocationModel(
      id: -1,
      address: address,
      lat: coords.latitude,
      lng: coords.longitude,
    );
    currentLoc.refresh();
    isLoading.value = false;
  }
}
