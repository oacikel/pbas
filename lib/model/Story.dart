import 'package:cloud_firestore/cloud_firestore.dart';
import "package:pbas/model/Chapter.dart";

class Story {
  final List<Chapter> chapters;
  int maxReachedStoryStop;

  Story({
    this.maxReachedStoryStop=0,
    this.chapters,
  });
}
