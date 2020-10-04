
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pbas/model/CONSTANTS.dart' as CONSTANTS;
import 'package:pbas/model/Story.dart';
import 'package:pbas/model/Chapter.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:pbas/model/eChapterStatus.dart';
import 'package:location/location.dart';

class MapHelper {
  static const String LOG_TAG = "OCULCAN - MapHelper: ";

  static PolylinePoints polylinePoints;
  static Location location;
  static LocationData currentLocation;
  static List<LatLng> polyLineCoordinates = [];

  static updateMarkerShapes(List<Chapter> chapters, List<Marker> markers) {
    //todo: buradaki markerları harita chapter durumuna göre değiştir
    chapters.forEach((chapter) {
      markers.add(Marker(
          markerId: MarkerId("MARKER-" + chapter.title),
          draggable: false,
          onTap: () {},
          position:
              LatLng(chapter.position.latitude, chapter.position.longitude)));
    });
  }

  static Future<LocationData> setInitialLocation() async {
    // set the initial location by pulling the user's
    // current location from the location's getLocation()
    currentLocation = await location.getLocation();
    return currentLocation;
  }

  static Future<Map<PolylineId, Polyline>> generatePaths(
      Story story, LocationData currentLocation) async {
    Map<PolylineId, Polyline> polylines = {};
    List<Chapter> chapters = story.chapters;
    for (int index = 0; index < chapters.length; index++) {
      if (story.maxReachedStoryStop > index) {
        debugPrint(LOG_TAG +
            "Chapter " +
            (index + 1).toString() +
            " has already been listened to");
        chapters[index].status = eChapterStatus.PAST_AVAILABLE;
        //Current storyStop has already been listened to
      } else if (story.maxReachedStoryStop == index) {
        //Current story stop is the current chapter in the story
        if (_isDeviceWithinStoryPointRange(currentLocation, chapters[index])) {
          debugPrint(LOG_TAG +
              "Chapter " +
              (index + 1).toString() +
              " is ready to be listened");
          chapters[index].status = eChapterStatus.CURRENT_AVAILABLE;
          //Chapter is ready to be listened
        } else {
          //Chapter is not within range
          debugPrint(LOG_TAG +
              "Chapter " +
              (index + 1).toString() +
              " is not within range. Adding a red polyline from device location");
          chapters[index].status = eChapterStatus.CURRENT_UNAVAILABLE;
          await _generatePathBetweenTwoPoints(index.toString() + "-red",
                  Colors.red, currentLocation, chapters[index].position)
              .then((value) => _addPolylineToMap(polylines, value));
        }
      } else if (story.maxReachedStoryStop < index) {
        debugPrint(LOG_TAG +
            "Chapter " +
            (index + 1).toString() +
            " is not yet available. Adding a grey polyline");
        //Current story stop is not yet available
        chapters[index].status = eChapterStatus.UPCOMING_UNAVAILABLE;
        await _generatePathBetweenTwoPoints(
                index.toString() + "-black",
                Colors.white38,
                chapters[index - 1].position,
                chapters[index].position)
            .then((value) => _addPolylineToMap(polylines, value));
      }

      //index++;

    }
    //chapters.forEach((storyStop)async {});

    return polylines;
  }

  static _addPolylineToMap(
      Map<PolylineId, Polyline> polylines, Polyline value) {
    polylines.remove(value.polylineId);
    polylines.putIfAbsent(value.polylineId, () => value);
  }

  static bool _isDeviceWithinStoryPointRange(
      LocationData deviceLocation, Chapter storyStop) {
    return (distanceBetween(deviceLocation.latitude, deviceLocation.longitude,
            storyStop.position.latitude, storyStop.position.longitude) <
        CONSTANTS.range);
  }

  static Future<Polyline> _generatePathBetweenTwoPoints(
      String id, Color color, var start, var end) async {
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
    polyLineCoordinates = [];
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    return Polyline(
        points: polyLineCoordinates,
        color: color,
        visible: true,
        polylineId: PolylineId(id),
        width: 3);
  }
}
