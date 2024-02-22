import 'dart:ffi';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapPage extends StatefulWidget {
  final dynamic data; // Define a parameter to receive data

  const MapPage({Key? key, required this.data}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _Topkapi = LatLng(41.013227881087566, 28.983042421483965);
  Location _locationController = new Location();
  LatLng? _currentP = null;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  Set<Marker> _createMarkers() {
    Set<Marker> markers = {};
    // Create markers using the received data
    dynamic data = widget.data;
    print(data);
    for (var item in data) {
      markers.add(
        Marker(
          markerId: MarkerId(item['id'].toString()),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(item['latitude'], item['longitude']),
          infoWindow: InfoWindow(title: item['name']),
        ),
      );
    }

    // Create marker for user's location if locationData is not null
    if (_currentP != null) {
      markers.add(
        Marker(
          markerId: MarkerId('user_location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: _currentP!,
          infoWindow: InfoWindow(title: 'Your Location'),
        ),
      );
    }

    //if locationData is null return green marker on _Topkapi
    if (_currentP == null) {
      markers.add(
        Marker(
          markerId: MarkerId('topkapi'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: _Topkapi,
          infoWindow: InfoWindow(title: 'default position'),
        ),
      );
    }

    return markers;
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? const Center(
              child: Text("Loading..."),
            )
          : GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _currentP!, zoom: 14.0),
              markers: _createMarkers(),
            ),
    );
  }
}
