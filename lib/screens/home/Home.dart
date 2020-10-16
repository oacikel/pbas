import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:pbas/screens/Home/PostList.dart';
import 'package:pbas/screens/Home/PostTile.dart';
import 'package:pbas/services/Database.dart';
import 'package:provider/provider.dart';
import 'package:pbas/screens/home/PostList.dart';
import 'package:pbas/model/objects/Post.dart';
import 'package:pbas/model/constants/CONSTANTS.dart' as CONSTANTS;



class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String LOG_TAG = "OCULCAN - HOME: ";
  DatabaseService databaseService=new DatabaseService();
  List<Post>posts;


  @override
  void initState() {
    databaseService.posts.listen((postList) {
      posts=postList;
      setState(() {});
      postList.forEach((post) {
        databaseService.updatePostWithUser(post)
            .whenComplete(() => setState((){debugPrint(LOG_TAG+"Updated a new story");}));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: CONSTANTS.paddingAppBar),
        child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 2.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: posts.length,
                itemBuilder: (context,index){
                return Container(
                  height: 160,
                  child: PostTile(
                    post: posts[index],
                  ),
                );
        })
        ),
      ),

    );
  }

}
