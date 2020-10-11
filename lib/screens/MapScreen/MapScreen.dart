import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pbas/Repository/Repository.dart';
import 'package:pbas/helper/MapHelper.dart';
import 'package:pbas/helper/StoryHelper.dart';
import 'package:pbas/model/Post.dart';
import 'package:pbas/model/enums/eChapterAccessStatus.dart';
import 'package:pbas/model/widgets/AudioPlayerController.dart';
import 'package:pbas/model/widgets/FABWithChapters.dart';
import 'package:pbas/screens/MapScreen/StoryControlWidget.dart';
import "package:pbas/screens/MapScreen/ChapterTile.dart";
import 'package:pbas/model/CONSTANTS.dart' as CONSTANTS;
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
  Repository repository=Repository();

  @override
  void initState() {
    super.initState();
    //Initialize Variables Here
    location=new Location();
    //Get Device Location => Set Chapter States => Initiate polylines
    MapHelper.getDeviceLocation(location)
        .then((value) => currentLocation=value)
        .then((value) =>  StoryHelper.updateChapterStates(widget.post.story, currentLocation))
        .then((value) => _updatePolylines(widget.post.story,currentLocation))
    //Setup Marker Assets Then Initialize Markers For Each Chapter
    .then((value) =>MapHelper.generateIconsForMarkers())
    .then((value) =>  MapHelper.addMarkerToEachChapter(widget.post.story.chapters, allMarkers))
    .whenComplete(() => setState((){}));
    //Observe Changes In Location
    location.onLocationChanged.listen((LocationData location) {
      if (distanceBetween(location.latitude, location.longitude, currentLocation.latitude, currentLocation.longitude)>25) {
        //Update Current Location
        currentLocation = location;
        //Update Polylines
        _updatePolylines(widget.post.story, currentLocation);
        //Update Chapter States
        StoryHelper.updateChapterStates(widget.post.story, currentLocation);
        //Update Markers On Map
        MapHelper.addMarkerToEachChapter(widget.post.story.chapters, allMarkers);
        //setState(() {});
      }
    });

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
        body: Stack(
          children: <Widget>[
            GoogleMap(
              padding: EdgeInsets.only(top:CONSTANTS.paddingAppBar,bottom: googleMapsPadding),
              zoomControlsEnabled: false,
              compassEnabled: false,
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
                      onTap:() {
                        debugPrint(LOG_TAG+"Chapter "+(index+1).toString()+" status is "+widget.post.story.chapters[index].accessStatus.toString());
                        if( widget.post.story.chapters[index].accessStatus==eChapterAccessStatus.CURRENT ||
                            widget.post.story.chapters[index].accessStatus==eChapterAccessStatus.UNLOCKED){
                          repository.selectedChapterIndex=index;
                          if (globalIndex == index) {
                            //Same chapter tile has been tapped just dismiss it if present or present it if not visible
                            switch (controller.status) {
                              case AnimationStatus.completed:
                                debugPrint(LOG_TAG + "Animation completed");
                                controller.reverse();
                                googleMapsPadding=0.0;
                                break;
                              case AnimationStatus.dismissed:
                                debugPrint(LOG_TAG + "Animation dismissed");
                                googleMapsPadding=104.0;
                                controller.forward();
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
                            setState(() {});
                          } else {
                            //Different chapter tile has been tapped. Dismiss the current one (if present) and restart animation
                            globalIndex = index;
                            switch (controller.status) {
                              case AnimationStatus.completed:
                                googleMapsPadding=104.0;
                                controller
                                    .reverse()
                                    .whenComplete(() => controller.forward());
                                break;
                              case AnimationStatus.dismissed:
                                googleMapsPadding=104.0;
                                controller.forward();
                                break;
                              case AnimationStatus.forward:
                              // TODO: Handle this case.
                                break;
                              case AnimationStatus.reverse:
                              // TODO: Handle this case.
                                break;
                            }
                            setState(() {});
                          }

                          debugPrint(LOG_TAG +
                              "Global index is: " +
                              globalIndex.toString());
                        }
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
    mapController.setMapStyle(CONSTANTS.googleMapStyleSilver);
  }

  _updatePolylines(Story story, LocationData deviceLocation) async {
    MapHelper.generatePaths(story, deviceLocation)
        .then((value) => polyLines=value)
        .whenComplete(() => setState((){}));
  }

}
