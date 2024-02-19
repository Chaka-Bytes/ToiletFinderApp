import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _KocUni = LatLng(41.20621054727754, 29.072417560915472);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _KocUni, zoom: 15.0),
        markers: {
          Marker(
            markerId: MarkerId('KocUni'),
            icon: BitmapDescriptor.defaultMarker,
            position: _KocUni,
            infoWindow: InfoWindow(title: 'Koc University'),
          ),
          Marker(
            markerId: MarkerId('KocUniRumeliFeneri'),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(41.19910700415913, 29.072074238185998),
            infoWindow:
                InfoWindow(title: 'Koc University Rumeli Feneri Campus'),
          ),
        },
      ),
    );
  }
}
