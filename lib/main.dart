// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbas/screens/ErrorScreen/ErrorScreen.dart';
import 'package:pbas/screens/home/Home.dart';
import 'package:pbas/screens/splashScreen/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot)  {
        // Check for errors
        if (snapshot.hasError) {
          debugPrint('OCULCAN - Main: Error  initializing Firebase '+snapshot.error.toString());  debugPrint("OCULCAN - Main: Please wait");
          return MaterialApp(
              title: "Error screen",
              home:ErrorScreen());
        }

        // Once complete, show your application
        else if (snapshot.connectionState == ConnectionState.done) {
          debugPrint('OCULCAN - Main: Initializing HomeScreen');
          return MaterialApp(
              title: 'Welcome to Flutter', home: Home());
        }else{
          debugPrint("OCULCAN - Main: Starting splash screen");
          return MaterialApp(
            title: "Splash screen",
            home:SplashScreen());
        }
      },
    );
  }

}
