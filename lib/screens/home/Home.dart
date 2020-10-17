import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:pbas/Repository/Repository.dart';
import 'package:pbas/model/objects/User.dart';
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
  Repository repository = Repository();
  User currentUser =new User();


  @override
  void initState() {
    repository.currentUser=currentUser;
    databaseService.posts.listen((postList) {
      repository.totalPostList=postList;
      setState(() {});
      postList.forEach((post) {
        databaseService.updatePostWithUser(post)
            .whenComplete(() => setState((){}));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: CONSTANTS.paddingAppBar),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: repository.totalPostList.length,
            itemBuilder: (context,index){
            return Container(
              child: GestureDetector(
                onTap: (){
                  if(repository.currentUser.focusedPost!=repository.totalPostList[index]){
                    repository.currentUser.focusedPost=repository.totalPostList[index];
                  }else{
                    repository.currentUser.focusedPost=null;
                  }
                  setState(() {
                  });
                },
                child: PostTile(
                  post: repository.totalPostList[index],
                ),
              ),
            );
        }),
      ),

    );
  }

}
