import 'package:blurrycontainer/blurrycontainer.dart';
import "package:flutter/material.dart";
import 'package:pbas/Repository/Repository.dart';
import 'package:pbas/model/objects/Post.dart';
import 'package:pbas/model/constants/CONSTANTS.dart' as CONSTANTS;
import 'package:pbas/model/constants/THEME_ELEMENTS.dart' as THEME;
import 'package:pbas/model/widgets/IconAndTextDark.dart';
import 'package:pbas/model/widgets/TextAndIconLight.dart';
import 'package:pbas/model/widgets/IconAndTextLight.dart';
import 'package:pbas/screens/MapScreen/MapScreen.dart';
import "package:permission_handler/permission_handler.dart";

class PostTile extends StatefulWidget {
  static String LOG_TAG ="OCULCAN - PostTile: ";
  final Post post;
  PostTile({this.post});

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  BuildContext context;
  String permissionStatusMessage;
  Repository repository =Repository();

  _setFocusedPost(){
    //If user has already focused this post unfocus it
    if (repository.currentUser.focusedPost!=null && repository.currentUser.focusedPost==widget.post){
      repository.currentUser.focusedPost=null;
    }
    //If user has focused a different post set this one the new focused post
    else if (repository.currentUser.focusedPost!=null && repository.currentUser.focusedPost!=widget.post){
      repository.currentUser.focusedPost=widget.post;
    }
    //If user has not yet set a focused post set this one the new focused post
    else if (repository.currentUser.focusedPost==null){
      repository.currentUser.focusedPost=widget.post;
    }
    setState(() {});
  }

  bool _isFocused(){
    return repository.currentUser.focusedPost!=widget.post;
  }

  @override
  Widget build(BuildContext context) {
    this.context=context;
    return Padding(
      padding: EdgeInsets.all(8),
      child: AnimatedSwitcher(
          duration:Duration(milliseconds:500 ),
          child: _isFocused()? PostTileFirst(widget.post):PostTileSecond(widget.post)),
    );
  }

  Future getSinglePermissionStatus() async {
    if (!await Permission.location.isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();
      debugPrint(PostTile.LOG_TAG+" "+statuses[Permission.location].toString());
    }
  }
}

class PostTileFirst extends StatelessWidget {
  Post post;

  PostTileFirst(this.post);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Container(
          height: THEME.CARD_HEIGHT,
          width: THEME.CARD_WIDTH,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: (NetworkImage(post.storyPhotoLink)),
                  colorFilter: ColorFilter.mode(
                      Colors.black54, BlendMode.darken),
                  fit: BoxFit.cover,),
              ),
              child: Container(
                padding:EdgeInsets.only(top:8,bottom:8,left: 9,right: 4),
                width: THEME.CARD_WIDTH,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.title,
                      style: THEME.styleTitleWhite,),
                    Text(post.user.userName,
                      style: THEME.styleSecondaryLight,),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndTextLight(
                            icon: Icons.access_time,
                            text: post.estimatedTimeInMinutes.toString()+THEME.textMinutes,
                          ),
                          IconAndTextLight(
                            icon: Icons.map,
                            text: post.travelDistanceInMeters.toString()+THEME.textMeters,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}

class PostTileSecond extends StatelessWidget {
  Post post;
  Repository repository=Repository();

  PostTileSecond(this.post);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: THEME.CARD_HEIGHT*1,
          width: THEME.CARD_WIDTH*1,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              padding:EdgeInsets.all(8),
              decoration: BoxDecoration(
                image: DecorationImage(image: (NetworkImage(post.storyPhotoLink)),
                  colorFilter: ColorFilter.mode(
                      Colors.white60, BlendMode.lighten),
                  fit: BoxFit.cover,),
              ),
              child: Container(
                width: THEME.CARD_WIDTH,
                child: BlurryContainer(
                  padding: EdgeInsets.all(3),
                  blur: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(post.title,
                                      style: THEME.styleTitleDark,),
                                    Text(post.user.userName,
                                      style: THEME.styleSecondaryDark,),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(post.user.userPictureLink),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height:100,
                              padding: EdgeInsets.only(top:8,bottom: 8),
                              child: SingleChildScrollView(
                                child: Text(post.description,
                                  style: THEME.styleSecondaryDark,),
                              ),
                            ),
                            Container(
                              width: THEME.CARD_MAP_IMAGE_WIDTH,
                              height:THEME.CARD_MAP_IMAGE_HEIGHT ,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: (NetworkImage(post.pathPhotoLink)),
                                  colorFilter: ColorFilter.mode(THEME.colorDark, BlendMode.saturation),
                                  fit: BoxFit.cover,),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconAndTextDark(
                                    icon: Icons.access_time,
                                    text: post.estimatedTimeInMinutes.toString()+THEME.textMinutes,
                                  ),
                                  IconAndTextDark(
                                    icon: Icons.map,
                                    text: post.travelDistanceInMeters.toString()+THEME.textMeters,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: SizedBox(
                          width: double.infinity,
                          child: RaisedButton.icon(onPressed: ((){
                            int returnZero(){return 0;}
                            repository.currentUser.selectedPosts.putIfAbsent(post,() =>returnZero());
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen(
                              post: repository.currentUser.selectedPosts.keys.firstWhere((post) => this.post==post),
                            )
                            ));
                          }),
                            highlightColor: THEME.primaryColor,
                            focusColor: THEME.primaryColor,
                            color: THEME.colorDark,
                            label: Text(THEME.textStart,style:THEME.styleTitleWhite,),
                            icon: Icon(Icons.directions_walk,color: THEME.colorLight,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



