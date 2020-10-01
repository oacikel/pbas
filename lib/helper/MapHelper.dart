import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pbas/model/CONSTANTS.dart' as CONSTANTS;
import 'package:pbas/model/Story.dart';
import 'package:pbas/model/StoryStop.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';



class MapHelper {
  static const String LOG_TAG="OCULCAN - MapHelper: ";

 static PolylinePoints polylinePoints;
 static List<LatLng> polyLineCoordinates=[];


  static Future<Map<PolylineId,Polyline>> generatePaths(Story story) async{
    //polyLineCoordinates=[];
    Map<PolylineId,Polyline> polylines={};
    Position deviceLocation = await GeolocatorPlatform.instance.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   // int index=0;
    List<StoryStop> storyStops=story.storyStops;
    for(int index=0;index<storyStops.length;index++){

      debugPrint(LOG_TAG+"index is: "+index.toString());
      if(story.maxReachedStoryStop>index){
        debugPrint(LOG_TAG+"Chapter "+(index+1).toString() +" has already been listened to");
        //Current storyStop has already been listened to
      } else if(story.maxReachedStoryStop==index){
        //Current story stop is the current chapter in the story
        if(_isDeviceWithinStoryPointRange(deviceLocation, storyStops[index])){
          debugPrint(LOG_TAG+"Chapter "+(index+1).toString() +" is ready to be listened");
          //Chapter is ready to be listened
        }else{
          //Chapter is not within range
          debugPrint(LOG_TAG+"Chapter "+(index+1).toString() +" is not within range. Adding a red polyline from device location");
          await _generatePathBetweenTwoPoints( index.toString()+"-red",Colors.red, deviceLocation, storyStops[index].position)
              .then((value) =>
              polylines.putIfAbsent(value.polylineId,()=>value));
        }
      } else if(story.maxReachedStoryStop<index){
        debugPrint(LOG_TAG+"Chapter "+(index+1).toString() +" is not yet available. Adding a grey polyline");
        //Current story stop is not yet available
        await _generatePathBetweenTwoPoints(index.toString()+"-black", Colors.white38, storyStops[index-1].position, storyStops[index].position)
            .then((value) => polylines.putIfAbsent(value.polylineId,()=>value))
            .whenComplete(() => debugPrint(LOG_TAG+"Added the grey polyline"));
      }

      //index++;

    }
    //storyStops.forEach((storyStop)async {});

     return polylines;
  }

    static bool _isDeviceWithinStoryPointRange(Position deviceLocation,StoryStop storyStop){
    return (distanceBetween(deviceLocation.latitude, deviceLocation.longitude, storyStop.position.latitude, storyStop.position.longitude)<CONSTANTS.range);
  }

  static Future <Polyline> _generatePathBetweenTwoPoints(String id,Color color, var start,var end) async{
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      CONSTANTS.googleMapsAPIKey, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(end.latitude, end.longitude),
      travelMode: TravelMode.walking,
    );
    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    return Polyline(
      points:polyLineCoordinates,
      color:color,
      visible: true,
      polylineId:PolylineId(id),
      width: 3
    );
  }

}
