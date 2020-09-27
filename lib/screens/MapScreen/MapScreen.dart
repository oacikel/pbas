import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pbas/model/Post.dart';
import "package:pbas/screens/MapScreen/StoryTile.dart";
import 'package:pbas/model/CONSTANTS.dart' as CONTANTS;
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:pbas/model/Story.dart';


class MapScreen extends StatefulWidget {
  final Post post;
  MapScreen({Key key, @required this.post}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static String LOG_TAG ="OCULCAN - MapScreen: ";
  static LatLng _initialPosition;
  static  LatLng _lastMapPosition = _initialPosition;
  PolylinePoints polyLinePoints;
  List<LatLng> polyLineCoordinates = [];
  GoogleMapController mapController;
  List<Marker> allMarkers = [];
  Map<PolylineId, Polyline> polyLines = {};
  final LatLng _center = const LatLng(40.98326, 29.040343);

  @override
  void initState () {
    //Add markers for each story point
    widget.post.story.storyStops.forEach((position) {
      allMarkers.add(Marker(
          markerId: MarkerId("Test Marker"),
          draggable: false,
          onTap: () {
            print("Marker tapped");
          },
          position: LatLng(position.latitude, position.longitude)));
    });
    //Create polyline route for the first story stop
    _createPolylines(widget.post.story);
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

          ],
        ));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  _createPolylines(Story story) async {
    // Initializing PolylinePoints
    Position start = await GeolocatorPlatform.instance.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    polyLinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polyLinePoints.getRouteBetweenCoordinates(
      "AIzaSyBo1856P2UlN9JMzANp6A9GZkFo0Hecfyo", // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(story.storyStops[0].latitude, story.storyStops[0].longitude),
      travelMode: TravelMode.transit,
    );
    debugPrint(LOG_TAG+"Results status: "+result.status);
    debugPrint(LOG_TAG+"Results error message: "+result.errorMessage);
    result.points.forEach((element) {
      debugPrint(LOG_TAG+"resulting point latitude: "+element.latitude.toString());
    });
    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      visible: true,
      points: polyLineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map,
    debugPrint(LOG_TAG+"Created Polyline: ");
    polyLines[id] = polyline;
    setState(() {
    });
  }
}