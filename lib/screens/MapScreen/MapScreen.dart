import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pbas/model/Post.dart';

class MapScreen extends StatefulWidget {
  final Post post;

  MapScreen({Key key, @required this.post}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  List<Marker> allMarkers = [];
  final LatLng _center = const LatLng(40.98326, 29.040343);

  @override
  void initState() {
    widget.post.story.storyStops.forEach((position) {
      allMarkers.add(Marker(
          markerId: MarkerId("Test Marker"),
          draggable: false,
          onTap: () {
            print("Marker tapped");
          },
          position: LatLng(position.latitude, position.longitude)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              markers: Set.from(allMarkers),
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),Container(
                child: ListView(
                  children: [
                    ListTile( title: Text('Sun'),
                    ),
                    ListTile(
                      title: Text('Moon'),
                    ),
                    ListTile(
                      title: Text('Star'),),
                  ],
                )),
          ],
        ));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
