import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:pbas/services/Database.dart';
import 'package:provider/provider.dart';
import 'package:pbas/screens/home/PostList.dart';
import 'package:pbas/model/Post.dart';
import  'package:pbas/model/CONSTANTS.dart' as CONSTANTS;



class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Post>>.value(
      value: DatabaseService().posts,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: CONSTANTS.paddingAppBar),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2.0,
                  child: PostList())]),
        ),
        
      ),
    );
  }

}
