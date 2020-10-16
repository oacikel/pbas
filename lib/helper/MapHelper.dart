
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pbas/model/constants/CONSTANTS.dart' as CONSTANTS;
import 'package:pbas/model/objects/Story.dart';
import 'package:pbas/model/objects/Chapter.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:pbas/model/enums/eChapterAccessStatus.dart';
import 'package:location/location.dart';

class MapHelper {
  static const String LOG_TAG = "OCULCAN - MapHelper: ";

  static PolylinePoints polylinePoints;
  static Location location;
  static LocationData currentLocation;
  static List<LatLng> polyLineCoordinates = [];
  static BitmapDescriptor _iconMapMakerUnlocked;
  static BitmapDescriptor _iconMapMakerNext;
  static BitmapDescriptor _iconMapMakerCurrent;
  static BitmapDescriptor _iconMapMakerLocked;

  static Future generateIconsForMarkers() {
    if (_iconMapMakerUnlocked == null) {
      BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(CONSTANTS.mapMarkerSize, CONSTANTS.mapMarkerSize)),
          'assets/icons/icon_map_marker_unlocked.bmp')
          .then((icon) {
        _iconMapMakerUnlocked = icon;
      });

      BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(CONSTANTS.mapMarkerSize, CONSTANTS.mapMarkerSize),
      ),
          'assets/icons/icon_map_marker_next.bmp')
          .then((icon) {
        _iconMapMakerNext = icon;
      });

      BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(CONSTANTS.mapMarkerSize, CONSTANTS.mapMarkerSize)),
          'assets/icons/icon_map_marker_current.bmp')
          .then((icon) {
        _iconMapMakerCurrent = icon;
      });

      BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(CONSTANTS.mapMarkerSize, CONSTANTS.mapMarkerSize)),
          'assets/icons/icon_map_marker_locked.bmp')
          .then((icon) {
        _iconMapMakerLocked = icon;
      });
    }
  }

  static addMarkerToEachChapter(List<Chapter> chapters, List<Marker>markers) {
    markers.clear();
    chapters.forEach((chapter) {
      switch (chapter.accessStatus) {
        case eChapterAccessStatus.UNLOCKED:
          markers.add(
              _createMarkerWihCustomIcon(chapter, _iconMapMakerUnlocked));
          break;
        case eChapterAccessStatus.CURRENT:
          markers.add(
              _createMarkerWihCustomIcon(chapter, _iconMapMakerCurrent));
          break;
        case eChapterAccessStatus.NEXT:
          markers.add(_createMarkerWihCustomIcon(chapter, _iconMapMakerNext));
          break;
        case eChapterAccessStatus.LOCKED:
          markers.add(_createMarkerWihCustomIcon(chapter, _iconMapMakerLocked));
          break;
      }
    });
  }
  static Marker _createMarkerWihCustomIcon(Chapter chapter,
      BitmapDescriptor icon) {
    return Marker(
        markerId: MarkerId("MARKER-" + chapter.title),
        icon: icon,
        draggable: false,
        onTap: () {},
        position:
        LatLng(chapter.position.latitude, chapter.position.longitude));
  }

  static Future<LocationData> getDeviceLocation(Location location) {
    return location.getLocation();
  }

  static Future<Map<PolylineId, Polyline>> generatePaths(Story story, LocationData currentLocation) async {
    Map<PolylineId, Polyline> polylines = {};
    List<Chapter> chapters = story.chapters;
    for (int index = 0; index < chapters.length; index++) {
        //Current story stop is the current chapter in the story
        if (chapters[index].accessStatus==eChapterAccessStatus.NEXT) {
            await _generatePathBetweenTwoPoints(index.toString() + "next",
              Colors.deepOrange, currentLocation, chapters[index].position)
              .then((value) => _addPolylineToMap(polylines, value));
        } else if (chapters[index].accessStatus==eChapterAccessStatus.LOCKED) {
            await _generatePathBetweenTwoPoints(
              index.toString() + "locked",
              CONSTANTS.darkColor,
              chapters[index - 1].position,
              chapters[index].position)
              .then((value) => _addPolylineToMap(polylines, value));
        }
    }
    return polylines;
  }


  static _addPolylineToMap(Map<PolylineId, Polyline> polylines,
      Polyline value) {
    polylines.remove(value.polylineId);
    polylines.putIfAbsent(value.polylineId, () => value);
  }

  static bool isDeviceWithinStoryPointRange(LocationData deviceLocation, Chapter storyStop) {
    debugPrint(LOG_TAG+"Location latitude is"+deviceLocation.longitude.toString());
    return (distanceBetween(deviceLocation.latitude, deviceLocation.longitude,
        storyStop.position.latitude, storyStop.position.longitude) <
        CONSTANTS.range);
  }

  static Future<Polyline> _generatePathBetweenTwoPoints(String id, Color color,
      var start, var end) async {
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
        width: 4);
  }

}

