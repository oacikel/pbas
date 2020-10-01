import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pbas/model/CONSTANTS.dart' as CONSTANTS;

class StoryStop {
  String audioLink;
  String imageLink;
  String title;
  GeoPoint position;

  StoryStop(this.audioLink, this.imageLink, this.title, this.position);

  StoryStop.fromMap(Map map):
        audioLink = map[CONSTANTS.fieldNameStoryStopStopAudioLink].toString(),
        imageLink = map[CONSTANTS.fieldNameStoryStopStopImageLink].toString(),
        title = map[CONSTANTS.fieldNameStoryStopStopTitle].toString(),
        position = map[CONSTANTS.fieldNameStoryStopStopPosition];
}
