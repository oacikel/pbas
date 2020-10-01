import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pbas/helper/MapHelper.dart';
import 'package:pbas/model/Post.dart';
import 'package:pbas/screens/MapScreen/StoryControlWidget.dart';
import "package:pbas/screens/MapScreen/StoryTile.dart";
import 'package:pbas/model/CONSTANTS.dart' as CONTANTS;
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:pbas/model/Story.dart';
import 'package:pbas/helper/MapHelper.dart';


class MapScreen extends StatefulWidget {
  final Post post;
  MapScreen({Key key, @required this.post}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static String LOG_TAG ="OCULCAN - MapScreen: ";
  GoogleMapController mapController;
  List<Marker> allMarkers = [];
  Map<PolylineId, Polyline> polyLines = {};
  final LatLng _center = const LatLng(40.98326, 29.040343);

  @override
  void initState () {
    //Add markers for each story point
    widget.post.story.storyStops.forEach((storyPoint) {
      allMarkers.add(Marker(
          markerId: MarkerId("Test Marker"),
          draggable: false,
          onTap: () {
            print("Marker tapped");
          },
          position: LatLng(storyPoint.position.latitude, storyPoint.position.longitude)));
    });
    //Create polyline route for the first story stop
    _updatePolylines(widget.post.story);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              padding:EdgeInsets.only(bottom:78),
              onMapCreated: _onMapCreated,
              markers: Set.from(allMarkers),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              polylines: Set<Polyline>.of(polyLines.values),
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 15.0,
              ),
            ),

            Container(
                width: 80,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: widget.post.story.storyStops.length,
                  itemBuilder: (context, index) {
                    return StoryTile(
                        story: widget.post.story,
                        order: index);
                  },

                )
            ),
            Container(
              alignment: Alignment.bottomCenter,
                child:StoryControlWidget(widget.post))

          ],
        ));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(CONTANTS.googleMapStyle);
    //mapController.setMapStyle('[{"featureType": "poi", "elementType": "labels", "stylers": [{ "visibility": "off" }]}]');
  }

  _updatePolylines (Story story)async {
    // Initializing PolylinePoints
     MapHelper.generatePaths(story)
         .then((value) =>_replacePolylines(value));
  }

    _replacePolylines(Map<PolylineId, Polyline>  value){
    polyLines.clear();
    setState(() {});
    polyLines=value;
    setState(() {});
}
}