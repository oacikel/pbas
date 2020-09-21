// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbas/screens/home/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          debugPrint('OCULCAN - Main: Error  initializing Firebase '+snapshot.error.toString());
        }

        // Once complete, show your application
        else if (snapshot.connectionState == ConnectionState.done) {
          debugPrint('OCULCAN - Main: Initializing HomeScreen');
          return MaterialApp(
              title: 'Welcome to Flutter', home: Home());
        }
        // Add a  splash screen here
        debugPrint("OCULCAN - Main: Please wait");
      },
    );
  }

}

/*
class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0, color: Colors.white);
  final _normalFont = TextStyle(fontSize: 12.0, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[_buildSuggestions()]),
    );
  }

  //Listview
  Widget _buildSuggestions() {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height / 2.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            final index = i ~/ 2;
            if (index >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10)); /*4*/
            }
            return _buildRow();
          }),
    );
  }

  //Buildrow

  Widget _buildRow() {
    return GestureDetector(
      onTap: showSelectedRouteDialog,
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width / 1.75,
        child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: (NetworkImage(
                        "https://d.neoldu.com/gallery/3453_8.jpg")),
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
                    child: Text("Küçükyalı Arkeopark",
                      style: _biggerFont,),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://media-exp1.licdn.com/dms/image/C5603AQEdkpvRdU0Ufw/profile-displayphoto-shrink_400_400/0?e=1605139200&v=beta&t=3OG8qLrCtKY-DKizDBG_b6zrXHcC1XBPVylIs6v4lN0"),
                              radius: 25,
                            )
                        )
                        ,
                        Container(
                            child: Text("Ocul",
                              textAlign: TextAlign.center,
                              style: _normalFont,)
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
                                Text("13km",
                                  style: _normalFont,)
                              ]),
                              Row(children: [
                                Icon(Icons.access_time,
                                  size: (12),
                                  color: Colors.white,),
                                Text("1 saat",
                                  textAlign: TextAlign.end,
                                  style: _normalFont,)
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
                              style: _normalFont,)),
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

  Function showSelectedRouteDialog(){
    Dialog errorDialog = Dialog(

      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 360.0,
        width: 300.0,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                child: Text('Küçükyalı Arkeopark', style: _biggerFont,)),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Text("İstanbul'un görkemli tarihsel yapılarından birisi de Ayasofya’nın güneybatısında bulunan Bazilika Saarnıcı’dır. Bizans İmparatoru I. Justinianus (527-565) tarafından yaptırılan bu büyük yeraltı sarnıcı, suyun içinden yükselen ve sayısız gibi görülen mermer sütunlar sebebiyle halk arasında “Yerebatan Sarayı” olarak isimlendirilmiştir. Sarnıcın bulunduğu yerde daha önce bir Bazilika bulunduğundan, Bazilika Sarnıcı olarak da anılır",
                  style: _normalFont),
            ),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.center,
                      children: [
                        Container(
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://media-exp1.licdn.com/dms/image/C5603AQEdkpvRdU0Ufw/profile-displayphoto-shrink_400_400/0?e=1605139200&v=beta&t=3OG8qLrCtKY-DKizDBG_b6zrXHcC1XBPVylIs6v4lN0"),
                              radius: 25,

                            )
                        ),
                        Text("Ocul",
                          textAlign: TextAlign.center,
                          style: _normalFont,)
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image(
                      width:100 ,
                      height: 100,

                      image: NetworkImage(
                        "https://c.tile.thunderforest.com/transport/12/2191/1522.png",
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
                          Icon(Icons.map,
                            size: (12),
                            color: Colors.white,),
                          Text("13km",
                            style: _normalFont,)
                        ]),
                        Row(children: [
                          Icon(Icons.access_time,
                            size: (12),
                            color: Colors.white,),
                          Text("1 saat",
                            textAlign: TextAlign.end,
                            style: _normalFont,)
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
                      color: Colors.blueAccent,
                      child: (Text("Başla",
                        style: _normalFont,)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => errorDialog);}


  Function showSelectedRouteDialog2() {
    showGeneralDialog(
        barrierLabel: "Label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (context,anim1,anim2){
          return Align(
            alignment: Alignment.center,
            child: Material(
              child: Container(
                  height: 300,
                  child:Column(children: [
                    Text("Küçükyalı Arkeopark",
                      style:_biggerFont,),
                    Text("İstanbul'un görkemli tarihsel yapılarından birisi de Ayasofya’nın güneybatısında bulunan Bazilika Saarnıcı’dır. Bizans İmparatoru I. Justinianus (527-565) tarafından yaptırılan bu büyük yeraltı sarnıcı, suyun içinden yükselen ve sayısız gibi görülen mermer sütunlar sebebiyle halk arasında “Yerebatan Sarayı” olarak isimlendirilmiştir. Sarnıcın bulunduğu yerde daha önce bir Bazilika bulunduğundan, Bazilika Sarnıcı olarak da anılır",
                      style: _normalFont,)
                  ],),
                  margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  )
              ),
            ),
          );
        }
    );
  }

}
 */
