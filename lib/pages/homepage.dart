import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CameraPosition _position = const CameraPosition(
    // add your own latitude and longitude
    target: LatLng(27.585576545309433, 84.50587184644867),
    zoom: 14.4746,
  );

  late GoogleMapController _controller;

  final List<Marker> markers = [];

  addMarker(coordinate) {
    int id = Random().nextInt(500);
    setState(() {
      markers.add(Marker(
          position: coordinate,
          markerId: MarkerId(
            id.toString(),
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: _position,
          mapType: MapType.hybrid,
          onMapCreated: (controller) {
            setState(() {
              _controller = controller;
            });
          },
          markers: markers.toSet(),
          onTap: (coordinate) {
            _controller.animateCamera(CameraUpdate.newLatLng(coordinate));
            addMarker(coordinate);
          },
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     _controller.animateCamera(CameraUpdate.zoomOut());
        //   },
        //   child: const Icon(Icons.zoom_out),
        // ),
      ),
    );
  }
}
