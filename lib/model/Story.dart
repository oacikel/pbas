import 'package:cloud_firestore/cloud_firestore.dart';
import "package:pbas/model/StoryStop.dart";

class Story {
  final List<StoryStop> storyStops;
  int maxReachedStoryStop;

  Story({
    this.maxReachedStoryStop=0,
    this.storyStops,
  });
}
