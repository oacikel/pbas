library CONSTANTS;


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbas/screens/MapScreen/MapScreen.dart';

//Style
final styleBiggerFont = TextStyle(fontSize: 18.0, color: Colors.white);
final styleHugeFontBlack = TextStyle(fontSize: 36.0, color: Colors.black);
final styleNormalFont = TextStyle(fontSize: 12.0, color: Colors.white);

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

//User Fields
const String fieldNameUserName="userName";
const String fieldNameUserPictureLink="userPictureLink";

//Google MapScreen
const String googleMapsAPIKey ="AIzaSyBZ-aAK6hvmyJT_LiGTC3BVaWM7LO3FEYc";
