
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class MapScreen extends StatefulWidget {

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  List<Marker> allMarkers = [];
  final LatLng _center = const LatLng(45.521563, -122.677433);


  @override
  void initState() {
    allMarkers.add(Marker(
      markerId: MarkerId("Test Marker"),
      draggable: false,
      onTap:(){
        print("Marker tapped");
      },
      position: _center
    ));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: GoogleMap(
      onMapCreated: _onMapCreated,
    markers: Set.from(allMarkers),
    initialCameraPosition: CameraPosition(
    target: _center,
    zoom: 11.0,
      ),
      )
    );
  }



}


