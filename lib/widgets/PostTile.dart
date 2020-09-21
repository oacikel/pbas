import "package:flutter/material.dart";
import "package:pbas/model/Post.dart";
import "package:pbas/model/CONSTANTS.dart" as CONSTANTS;
import 'package:pbas/helper/DialogHelper.dart';

class PostTile extends StatelessWidget {

  final Post post;
  PostTile({this.post});
  BuildContext context;


  @override
  Widget build(BuildContext context) {
    this.context=context;
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width / 1.75,
      child: GestureDetector(
        onTap:()=>DialogHelper.showSelectedPostDialog(post,context),
        child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: (NetworkImage(
                        post.storyPhotoLink)),
                    colorFilter: ColorFilter.mode(
                        Colors.black54, BlendMode.darken),
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                  )
              ),
              child: Column(
                //mainAxisAlignment:MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(post.title,
                      style: CONSTANTS.styleBiggerFont,),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                post.user.userPictureLink),
                              radius: 25,
                            )
                        )
                        ,
                        Container(
                            child: Text(
                              post.user.userName,
                              textAlign: TextAlign.center,
                              style: CONSTANTS.styleNormalFont,)
                        ),
                      ],
                    ),
                  ),

                  Expanded(
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
                                Icon(Icons.map,
                                  size: (12),
                                  color: Colors.white,),
                                Text(post.travelDistanceInMeters.toString() +
                                    " metre",
                                  style: CONSTANTS.styleNormalFont,)
                              ]),
                              Row(children: [
                                Icon(Icons.access_time,
                                  size: (12),
                                  color: Colors.white,),
                                Text(post.estimatedTimeInMinutes.toString() +
                                    " dakika",
                                  textAlign: TextAlign.end,
                                  style: CONSTANTS.styleNormalFont,)
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
                                borderRadius: BorderRadius.circular(18.0)
                            ),
                            color: Colors.black12,
                            child: (Text("Başla",
                              style: CONSTANTS.styleNormalFont,)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
