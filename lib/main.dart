import 'package:flutter/material.dart';

import 'package:chess_game/pages/home.dart';
import 'package:chess_game/pages/game.dart';
import 'package:chess_game/pages/credits.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //make the app only portrait [completed]
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
  static const specialBlue = Color(0xff00a4aa);

  final defaultTheme = ThemeData(
    //appBarTheme [completed]
    appBarTheme: const AppBarTheme(
      color: specialBlue,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    //buttonTheme [completed]
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: specialBlue,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(3.0),
      ),
    ),

    //dialogTheme [completed]
    dialogTheme: DialogTheme(
      backgroundColor: specialBlue,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
    ),

    scaffoldBackgroundColor: specialBlue,
  );

  final routes = {
    'home': (context) => const Home(),
    'game': (context) => const Game(),
    'credits': (context) => const Credits(),
  };

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioPlayer? advancedPlayer;
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
    advancedPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      theme: widget.defaultTheme,
      routes: widget.routes,
    );
  }
}
