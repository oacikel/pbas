import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:pbas/model/Chapter.dart';
import 'package:pbas/model/Post.dart';
import 'package:pbas/model/CONSTANTS.dart' as CONSTANTS;
import 'package:pbas/model/Story.dart';
import 'package:pbas/model/eChapterStatus.dart';
import 'package:pbas/helper/MapHelper.dart';

class StoryHelper {

  static updateChapterStates(Story story, LocationData currentLocation) {
    List<Chapter>chapters = story.chapters;
    for (int index = 0; index < chapters.length; index++) {
      if (story.maxReachedStoryStop > index) {
        //This chapter has already been listened to
        chapters[index].status = eChapterStatus.UNLOCKED;
      } else if (story.maxReachedStoryStop == index) {
        //Current story stop is the current chapter in the story
        if (MapHelper.isDeviceWithinStoryPointRange(currentLocation, chapters[index])) {
          //Chapter is ready to be listened
          chapters[index].status = eChapterStatus.CURRENT;
        } else {
          //Chapter is not within range
          chapters[index].status = eChapterStatus.NEXT;
        }
      } else if (story.maxReachedStoryStop < index) {
        //Current story stop is not yet available
        chapters[index].status = eChapterStatus.LOCKED;
      }
    }
  }

}
