library CONSTANTS;


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbas/screens/MapScreen/MapScreen.dart';

//
final int range =25;

//Style
final styleBigFontWhite = TextStyle(fontSize: 18.0, color: Colors.white);
final styleBigFontBlack = TextStyle(fontSize: 18.0, color: Colors.black);
final styleHugeFontBlack = TextStyle(fontSize: 36.0, color: Colors.black);
final styleHugeFontWhite = TextStyle(fontSize: 36.0, color: Colors.white);
final styleNormalFont = TextStyle(fontSize: 12.0, color: Colors.white);
final styleNormalFontBlack = TextStyle(fontSize: 12.0, color: Colors.black);


//Firebase

//References
const String posts_reference="posts";
const String users_reference="users";
const String cities_reference="cities";

//Post Fields
const String fieldNameTitle="title";
const String fieldNameCategoryReference="categoryReference";
const String fieldNameCityReference="cityReference";
const String fieldNameDescription="description";
const String fieldNamePathPhotoLink="pathPhotoLink";
const String fieldNameStoryPhotoLink="storyPhotoLink";
const String fieldNameUploaderReference="uploader";
const String fieldNameEstimatedTimeInMinutes="estimatedTimeInMinutes";
const String fieldNameTravelDistanceInMeters="travelDistanceInMeters";
const String fieldNameStoryStops="storyStops";
    //StoryStopField
const String fieldNameStoryStopStopAudioLink ="storyStopAudioLink";
const String fieldNameStoryStopStopImageLink="storyStopImageLink";
const String fieldNameStoryStopStopTitle="storyStopTitle";
const String fieldNameStoryStopStopPosition="storyStopPosition";

//User Fields
const String fieldNameUserName="userName";
const String fieldNameUserPictureLink="userPictureLink";

//Google MapScreen
const String googleMapsAPIKey ="AIzaSyBo1856P2UlN9JMzANp6A9GZkFo0Hecfyo";
const String googleMapStyle="[{\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#212121\"}]},{\"elementType\":\"labels.icon\",\"stylers\":[{\"visibility\":\"off\"}]},{\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#757575\"}]},{\"elementType\":\"labels.text.stroke\",\"stylers\":[{\"color\":\"#212121\"}]},{\"featureType\":\"administrative\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#757575\"}]},{\"featureType\":\"administrative.country\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#9e9e9e\"}]},{\"featureType\":\"administrative.locality\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#bdbdbd\"}]},{\"featureType\":\"poi\",\"stylers\":[{\"visibility\":\"off\"}]},{\"featureType\":\"poi\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#757575\"}]},{\"featureType\":\"poi.park\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#181818\"}]},{\"featureType\":\"poi.park\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#616161\"}]},{\"featureType\":\"poi.park\",\"elementType\":\"labels.text.stroke\",\"stylers\":[{\"color\":\"#1b1b1b\"}]},{\"featureType\":\"road\",\"elementType\":\"geometry.fill\",\"stylers\":[{\"color\":\"#2c2c2c\"}]},{\"featureType\":\"road\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#8a8a8a\"}]},{\"featureType\":\"road.arterial\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#373737\"}]},{\"featureType\":\"road.highway\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#3c3c3c\"}]},{\"featureType\":\"road.highway.controlled_access\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#4e4e4e\"}]},{\"featureType\":\"road.local\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#616161\"}]},{\"featureType\":\"transit\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#757575\"}]},{\"featureType\":\"water\",\"elementType\":\"geometry\",\"stylers\":[{\"color\":\"#000000\"}]},{\"featureType\":\"water\",\"elementType\":\"labels.text.fill\",\"stylers\":[{\"color\":\"#3d3d3d\"}]}]";