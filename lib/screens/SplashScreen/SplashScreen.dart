import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:pbas/services/Database.dart';
import 'package:provider/provider.dart';
import 'package:pbas/screens/home/PostList.dart';
import 'package:pbas/model/Post.dart';



class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        child: Text(
          "loading app..."
        ),
      ),
    );
  }

}
