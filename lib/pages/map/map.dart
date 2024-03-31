import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants/style.dart';

class GMap extends StatefulWidget {
  const GMap({Key? key}) : super(key: key);

  @override
  State<GMap> createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> markers = {};

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.5636616, 77.2890546),
    zoom: 15,
  );

  @override
  void initState() {
    addMarkers();
    super.initState();
  }

  Set<Circle> circles = Set.from([
    for (double i = 0; i < 5; i += 1)
      Circle(
        circleId: CircleId("$i"),
        center: LatLng(28.5636616 + (i / (100 + Random().nextInt(100))),
            77.2890546 - (i / (100 + Random().nextInt(100)))),
        radius: 200 + Random().nextInt(500).toDouble(),
        strokeColor: Colors.transparent,
        fillColor: Colors.redAccent.withOpacity(0.5),
      )
  ]);

  addMarkers() async {
    BitmapDescriptor mark = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/icons/marker.png",
    );

    List<Marker> markerList = [
      for (double i = 0; i < 30; i += 1)
        Marker(
          markerId: MarkerId(
              const LatLng(28.5636616, 77.2890546).toString() + i.toString()),
          position: LatLng(28.5636616 + (i / (500 + Random().nextInt(500))),
              77.2890546 - (i / (300 + Random().nextInt(800)))),
          infoWindow: InfoWindow(
            title: 'Starting Point $i ',
            snippet: 'Start Marker $i',
          ),
          icon: mark,
        ),
    ];

    for (int i = 0; i < markerList.length; i++) {
      markers.add(markerList[i]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          controller.setMapStyle(style);
        },
        circles: circles,
      ),
    );
  }
}
