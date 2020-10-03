import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pbas/model/CONSTANTS.dart' as CONSTANTS;
import 'package:pbas/model/eChapterStatus.dart';

class Chapter {
  String audioLink;
  String imageLink;
  String title;
  GeoPoint position;
  eChapterStatus status;

  Chapter(this.audioLink, this.imageLink, this.title, this.position);

  Chapter.fromMap(Map map):
        audioLink = map[CONSTANTS.fieldNameStoryStopStopAudioLink].toString(),
        imageLink = map[CONSTANTS.fieldNameStoryStopStopImageLink].toString(),
        title = map[CONSTANTS.fieldNameStoryStopStopTitle].toString(),
        position = map[CONSTANTS.fieldNameStoryStopStopPosition];
}
