import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  late Location _location;
  LatLng? _locationPosition;

  late BitmapDescriptor _pinLocation;
  late Map<MarkerId, Marker> _markers;

  final MarkerId markerId = const MarkerId('1');

  late GoogleMapController _controller;

  Location get location => _location;
  LatLng? get locationPosition => _locationPosition;
  BitmapDescriptor get pinLocation => _pinLocation;
  Map<MarkerId, Marker> get markers => _markers;
  GoogleMapController get controller => _controller;

  bool locationServiceActive = false;

  LocationProvider() {
    _location = Location();
  }

  initilization() async {
    await getUserLocation();
    await setCustomMapPin();
  }

  getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      _locationPosition = LatLng(
        currentLocation.latitude!.toDouble(),
        currentLocation.longitude!.toDouble(),
      );

      debugPrint(_locationPosition.toString());
      _markers = <MarkerId, Marker>{};
      Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
          currentLocation.latitude!.toDouble(),
          currentLocation.longitude!.toDouble(),
        ),
        icon: _pinLocation,
        draggable: true,
        onDragEnd: ((newPostioned) {
          _locationPosition = LatLng(
            newPostioned.latitude,
            newPostioned.longitude,
          );
          notifyListeners();
        }),
      );
      _markers[markerId] = marker;
      notifyListeners();
    });
  }

  setCustomMapPin() async {
    _pinLocation = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
  }

  setMapController(controller) {
    _controller = controller;
    notifyListeners();
  }
}
