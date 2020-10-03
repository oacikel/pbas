import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pbas/model/Post.dart';
import "package:pbas/screens/MapScreen/ChapterTile.dart";
import 'package:pbas/model/CONSTANTS.dart' as CONTANTS;
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:pbas/model/Story.dart';

class StoryControlWidget extends StatelessWidget {
  Post post;

  StoryControlWidget(this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width ,
      height: 84,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38)),
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(post.story.chapters[0].imageLink),
            radius: 30,),
            Container(
              padding:EdgeInsets.all(8),
              alignment: Alignment.topLeft,
              child: Text ("Başlamak için ilk durağa gidin!",
              style: CONTANTS.styleNormalFontBlack,),
            ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon:Icon(Icons.navigation),
                    iconSize: 30,
                  ),
                ),
              )
            ],
          ),
        ) ,
      ),
    );
  }
}
