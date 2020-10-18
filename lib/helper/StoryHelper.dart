import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:pbas/Repository/Repository.dart';
import 'package:pbas/model/objects/Chapter.dart';
import 'package:pbas/model/objects/Post.dart';
import 'package:pbas/model/constants/CONSTANTS.dart' as CONSTANTS;
import 'package:pbas/model/objects/Story.dart';
import 'package:pbas/model/enums/eChapterAccessStatus.dart';
import 'package:pbas/helper/MapHelper.dart';

class StoryHelper {
  static Repository repository =Repository();

  static updateChapterStates(Post post, LocationData currentLocation) {
    Story story=post.story;
    List<Chapter>chapters = story.chapters;
    for (int index = 0; index < chapters.length; index++) {
      if (story.maxReachedStoryStop > index) {
        //This chapter has already been listened to
        chapters[index].accessStatus = eChapterAccessStatus.UNLOCKED;
      } else if (story.maxReachedStoryStop == index) {
        //Current story stop is the current chapter in the story
        if (MapHelper.isDeviceWithinStoryPointRange(currentLocation, chapters[index])) {
          //Chapter is ready to be listened
          chapters[index].accessStatus = eChapterAccessStatus.CURRENT;
        } else {
          //Chapter is not within range
          chapters[index].accessStatus = eChapterAccessStatus.NEXT;
        }
      } else if (story.maxReachedStoryStop < index) {
        //Current story stop is not yet available
        chapters[index].accessStatus = eChapterAccessStatus.LOCKED;
      }
    }
  }

}
