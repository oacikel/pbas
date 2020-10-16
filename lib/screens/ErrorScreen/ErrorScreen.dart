import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:pbas/services/Database.dart';
import 'package:provider/provider.dart';
import 'package:pbas/screens/home/PostList.dart';
import 'package:pbas/model/objects/Post.dart';



class ErrorScreen extends StatefulWidget {

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        child: Text(
            "an error has occured..."
        ),
      ),
    );
  }

}
