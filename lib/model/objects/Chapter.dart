import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pbas/model/constants/CONSTANTS.dart' as CONSTANTS;
import 'package:pbas/model/enums/eChapterAccessStatus.dart';
import 'package:pbas/model/enums/eChapterFocusStatus.dart';

class Chapter {
  String audioLink;
  String imageLink;
  String title;
  GeoPoint position;
  eChapterAccessStatus accessStatus;
  eChapterFocusStatus playStatus;

  Chapter(this.audioLink, this.imageLink, this.title, this.position);
  Chapter.fromMap(Map map):
        audioLink = map[CONSTANTS.fieldNameStoryStopStopAudioLink].toString(),
        imageLink = map[CONSTANTS.fieldNameStoryStopStopImageLink].toString(),
        title = map[CONSTANTS.fieldNameStoryStopStopTitle].toString(),
        position = map[CONSTANTS.fieldNameStoryStopStopPosition];
}
