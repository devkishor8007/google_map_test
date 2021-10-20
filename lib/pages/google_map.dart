import 'package:flutter/material.dart';
import 'package:google_map_flutter/provider/location_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GoogleMapScreen extends StatelessWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (BuildContext context, value, Widget? child) {
        if (value.locationPosition == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: value.locationPosition!,
            zoom: 14.4746,
          ),
          mapType: MapType.normal,
          onMapCreated: (controller) {
            value.setMapController(controller);
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: Set<Marker>.of(value.markers.values),
        );
      },
    );
  }
}
