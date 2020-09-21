import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pbas/model/Post.dart';
import 'package:pbas/model/CONSTANTS.dart' as CONSTANTS;

class DialogHelper {
  static Function showSelectedPostDialog(Post post, BuildContext context) {
    Dialog dialog = Dialog(
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: 360.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                child: Text(
                  post.title,
                  style: CONSTANTS.styleBiggerFont,
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Text(post.description, style: CONSTANTS.styleNormalFont),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            child: CircleAvatar(
                          backgroundImage: NetworkImage(
                           post.user.userPictureLink
                          ),
                          radius: 25,
                        )),
                        Text(post.user.userName,
                          textAlign: TextAlign.center,
                          style: CONSTANTS.styleNormalFont,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image(
                      width: 100,
                      height: 100,
                      image: NetworkImage(
                        post.pathPhotoLink,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(children: [
                          Icon(
                            Icons.map,
                            size: (12),
                            color: Colors.white,
                          ),
                          Text(
                            post.travelDistanceInMeters.toString() + " metre",
                            style: CONSTANTS.styleNormalFont,
                          )
                        ]),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: (12),
                              color: Colors.white,
                            ),
                            Text(
                              post.estimatedTimeInMinutes.toString() +
                                  " dakika",
                              textAlign: TextAlign.end,
                              style: CONSTANTS.styleNormalFont,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      color: Colors.blueAccent,
                      child: (Text(
                        "Başla",
                        style: CONSTANTS.styleNormalFont,
                      )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
