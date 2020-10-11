import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import "package:flutter/material.dart";
import 'package:pbas/Repository/Repository.dart';
import 'package:pbas/model/Chapter.dart';
import 'package:pbas/model/Story.dart';
import "package:pbas/model/CONSTANTS.dart"  as CONSTANTS;
import 'package:pbas/model/enums/eChapterAccessStatus.dart';
import 'package:pbas/model/enums/eChapterAccessStatus.dart';
import 'package:pbas/model/enums/eChapterFocusStatus.dart';

class ChapterTile extends StatelessWidget {
  String LOG_TAG ="OCULCAN-ChapterTile: ";
  final Story story;
  final int order;

  ChapterTile({this.story, this.order});
  Repository repository=Repository();

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Align(
      alignment: Alignment.topLeft,
      child:
        Container(
          width:74,
          height: 74,
          child: Stack(
            children: [Padding(
              padding: const EdgeInsets.only(left:4.0,top:4),
              child: ColorFiltered(
                colorFilter: !_isChapterToBeColored()?
                ColorFilter.matrix(<double>[
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]) :
                ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: (NetworkImage(
                        story.chapters[order].imageLink)),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                  )
            )
        ),
              Padding(
                padding: const EdgeInsets.only(left:4.0,top:4),
                child: ClipRect(
                  child: BlurryContainer(
                    borderRadius: BorderRadius.circular(37),
                    blur: _isChapterToBeBlurred()?
                    2:0,
                    child:Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle),
                    )
                  ),
                ),
              )
            ]
          ),
      )
    );
  }

  IconData _generateIconAccordingToChapterState(Chapter chapter){
    switch(chapter.accessStatus){
      case eChapterAccessStatus.UNLOCKED:{
      return (Icons.lock_open);
      }break;
      case eChapterAccessStatus.CURRENT:{
        return (Icons.star);
      }break;
      case eChapterAccessStatus.NEXT:{
        return (Icons.navigate_next);
      }break;
      case eChapterAccessStatus.LOCKED:{
        return (Icons.lock_outline);
      }break;
    }
  }

  bool _isChapterToBeColored(){
    if(repository.selectedChapterIndex==null){
      return false;
    }
    return order==repository.selectedChapterIndex;
  }

  bool _isChapterToBeBlurred(){
    debugPrint(LOG_TAG+"Chapter "+ order.toString()+" status is: "+story.chapters[order].accessStatus.toString());
    return (story.chapters[order].accessStatus==eChapterAccessStatus.LOCKED);
  }
}
