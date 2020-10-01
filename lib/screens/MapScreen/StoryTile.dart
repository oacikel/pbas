import "package:flutter/material.dart";
import 'package:pbas/model/Story.dart';
import "package:pbas/model/CONSTANTS.dart"  as CONSTANTS;

class StoryTile extends StatelessWidget {
  final Story story;
  final int order;

  StoryTile({this.story, this.order});

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
          width:78,
          height: 70,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(right:8.0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                        image: DecorationImage(
                          image: (NetworkImage(
                              story.storyStops[order].imageLink)),

                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                    ),
                    child: Text(
                      (order + 1).toString(),
                      style: CONSTANTS.styleHugeFontWhite,),
                  )
            ),
              ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.5)),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(Icons.directions_walk,
                size: 25,),
              ),
            )]
          )
      ),
    );
  }
}
