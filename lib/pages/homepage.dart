import 'package:flutter/material.dart';
import 'package:google_map_flutter/pages/google_map.dart';
import 'package:google_map_flutter/provider/location_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).initilization();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(body: GoogleMapScreen()),
    );
  }
}
