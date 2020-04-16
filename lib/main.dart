import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chess/pages/home.dart';
import 'package:chess/pages/game.dart';
import 'package:chess/pages/credits.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  static Color specialBlue = Color(0xff00a4aa);

  final defaultTheme = ThemeData(
    //appBarTheme [completed]
    appBarTheme: AppBarTheme(
        color: specialBlue, iconTheme: IconThemeData(color: Colors.white)),

    //buttonTheme [completed]
    buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        buttonColor: specialBlue,
        shape:
            BeveledRectangleBorder(borderRadius: BorderRadius.circular(3.0))),

    //dialogTheme [completed]
    dialogTheme: DialogTheme(
        backgroundColor: specialBlue,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(3))),

    scaffoldBackgroundColor: specialBlue,
  );

  final routes = <String, WidgetBuilder>{
    'home': (BuildContext context) => Home(),
    'game': (BuildContext context) => Game(),
    'credits': (BuildContext context) => Credits(),
  };

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioPlayer advancedPlayer;
  bool isMusicOn = true;

  @override
  initState() {
    super.initState();
    loadMusic();
  }

  Future loadMusic() async {
    advancedPlayer = await AudioCache().loop("music/Jazz-1.mp3");
  }

  @override
  void dispose() {
    advancedPlayer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: widget.defaultTheme,
      routes: widget.routes,
    );
  }
}
