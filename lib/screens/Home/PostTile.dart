import "package:flutter/material.dart";
import 'package:pbas/model/objects/Post.dart';
import 'package:pbas/model/constants/CONSTANTS.dart' as CONSTANTS;
import 'package:pbas/model/constants/THEME_ELEMENTS.dart' as THEME;
import 'package:pbas/helper/DialogHelper.dart';
import 'package:pbas/model/widgets/TextAndIcon.dart';
import 'package:pbas/model/widgets/IconAndText.dart';
import 'package:pbas/screens/MapScreen/MapScreen.dart';
import "package:permission_handler/permission_handler.dart";

class PostTile extends StatelessWidget {
  static String LOG_TAG ="OCULCAN - PostTile: ";
  final Post post;
  PostTile({this.post});
  BuildContext context;
  String permissionStatusMessage;


  @override
  Widget build(BuildContext context) {
    this.context=context;
    return GestureDetector(
      onTap:()=>DialogHelper.showSelectedPostDialog(post,context),
      child: Column(
        children: [
          Container(
            height: THEME.CARD_HEIGHT,
            width: THEME.CARD_WIDTH,
            child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(
                  post.storyPhotoLink,
                  fit: BoxFit.cover),
              ),
          ),
          Container(
            padding:EdgeInsets.only(left: 9,right: 4),
            width: THEME.CARD_WIDTH,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post.title,
                              style: THEME.styleTitleDark,),
                              Text(post.user.userName,
                                style: THEME.styleSecondaryDark,)
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconAndText(
                              icon: Icons.access_time,
                              text: post.estimatedTimeInMinutes.toString()+THEME.textMinutes,
                            ),
                            IconAndText(
                              icon: Icons.map,
                              text: post.travelDistanceInMeters.toString()+THEME.textMeters,
                            )
                          ],
                        ),
                        ],
            ),
          ),
        ],
      ),
    );
  }
  /*
  Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: (NetworkImage(
                            post.storyPhotoLink)),
                        colorFilter: ColorFilter.mode(
                            Colors.black54, BlendMode.darken),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      )
                  ),
                )
   */

  Future getSinglePermissionStatus() async {
    if (!await Permission.location.isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();
      debugPrint(LOG_TAG+" "+statuses[Permission.location].toString());
    }
  }

}
