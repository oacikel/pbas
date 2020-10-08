import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pbas/helper/MapHelper.dart';
import 'package:pbas/model/Post.dart';
import 'package:pbas/model/widgets/AudioPlayerController.dart';
import 'package:pbas/screens/MapScreen/StoryControlWidget.dart';
import "package:pbas/screens/MapScreen/ChapterTile.dart";
import 'package:pbas/model/CONSTANTS.dart' as CONTANTS;
import 'package:pbas/model/Story.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  final Post post;

  MapScreen({Key key, @required this.post}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  static String LOG_TAG = "OCULCAN - MapScreen: ";
  GoogleMapController mapController;
  List<Marker> allMarkers = [];
  Map<PolylineId, Polyline> polyLines = {};
  Location location;
  final LatLng _center = const LatLng(40.98326, 29.040343);
  Animation<Offset> offset;
  AnimationController controller;
  LocationData currentLocation;
  int globalIndex;
  double googleMapsPadding=0;

  @override
  void initState() {
    super.initState();
    //Add markers for each story point
    MapHelper.updateMarkerShapes(widget.post.story.chapters, allMarkers);
    //Create polyline route for the first story stop
    location = new Location();
    location
        .getLocation()
        .then((value) => currentLocation = value)
        .whenComplete(
            () => _updatePolylines(widget.post.story, currentLocation));
    _watchLocationChanges();

    //Animaion controller
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    offset = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(controller);
    //Set Global Index
    globalIndex=0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              padding: EdgeInsets.only(bottom: googleMapsPadding),
              onMapCreated: _onMapCreated,
              markers: Set.from(allMarkers),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              polylines: Set<Polyline>.of(polyLines.values),
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 13.0,
              ),
            ),
            Container(
                width: 80,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: widget.post.story.chapters.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (globalIndex == index) {
                          //Same chapter tile has been tapped just dismiss it if present or present it if not visible
                          setState(() {});
                          switch (controller.status) {
                            case AnimationStatus.completed:
                              debugPrint(LOG_TAG + "Animation completed");
                              controller.reverse();
                              googleMapsPadding=0.0;
                              setState(() {});
                              break;
                            case AnimationStatus.dismissed:
                              debugPrint(LOG_TAG + "Animation dismissed");
                              googleMapsPadding=104.0;
                              controller.forward();
                              setState(() {});
                              break;
                            case AnimationStatus.forward:
                              debugPrint(LOG_TAG + "Animation forward");
                              // TODO: Handle this case.
                              break;
                            case AnimationStatus.reverse:
                              debugPrint(LOG_TAG + "Animation reverse");
                              // TODO: Handle this case.
                              break;
                          }
                        } else {
                          //Different chapter tile has been tapped. Dismiss the current one (if present) and restart animation

                          setState(() {globalIndex = index;});
                          switch (controller.status) {
                            case AnimationStatus.completed:
                              googleMapsPadding=104.0;
                              controller
                                  .reverse()
                                  .whenComplete(() => controller.forward());
                              setState(() {});
                              break;
                            case AnimationStatus.dismissed:
                              googleMapsPadding=104.0;
                              controller.forward();
                              setState(() {});
                              break;
                            case AnimationStatus.forward:
                              // TODO: Handle this case.
                              break;
                            case AnimationStatus.reverse:
                              // TODO: Handle this case.
                              break;
                          }
                        }

                        debugPrint(LOG_TAG +
                            "Global index is: " +
                            globalIndex.toString());
                      },
                      child: ChapterTile(
                        story: widget.post.story,
                        order: index,
                      ),
                    );
                  },
                )),
            Container(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                  position: offset,
                  child: AudioPlayerController(widget.post.story.chapters[globalIndex])),
            )
          ],
        ));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(CONTANTS.googleMapStyle);
    //mapController.setMapStyle('[{"featureType": "poi", "elementType": "labels", "stylers": [{ "visibility": "off" }]}]');
  }

  _updatePolylines(Story story, LocationData deviceLocation) async {
    // Initializing PolylinePoints
    debugPrint(LOG_TAG + "Updating polylines.");

    MapHelper.generatePaths(story, deviceLocation)
        .then((value) => _replacePolylines(value));
  }

  _replacePolylines(Map<PolylineId, Polyline> value) {
    polyLines = value;
    setState(() {});
  }

  _watchLocationChanges() {
    Stream<LocationData> locationData = location.onLocationChanged;
    locationData.listen((LocationData location) {
      if (distanceBetween(location.latitude, location.longitude,
              currentLocation.latitude, currentLocation.longitude) >
          25) {
        debugPrint(LOG_TAG +
            "Location changed by " +
            distanceBetween(location.latitude, location.longitude,
                    currentLocation.latitude, currentLocation.longitude)
                .floor()
                .toString() +
            "meters");
        currentLocation = location;
        _updatePolylines(widget.post.story, currentLocation);
      }
    });
  }
}
