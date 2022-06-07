import 'package:flutter/material.dart';

import 'game.dart' show multiPlayerMode;

late double widthOrHeight;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //determine the height and the width of the chess icons
    widthOrHeight = MediaQuery.of(context).size.width / 8;

    return Scaffold(
      //appBar [completed]
      appBar: AppBar(
        title: const Text('Chess'),
      ),

      //(start button + credits button + chess background)
      body: Container(
        //Wallpaper
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/chessWallpaper/wallpaper-1.jpg'),
            fit: BoxFit.cover,
          ),
        ),

        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //multi player
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 50,
                  primary: const Color(0xff00a4aa),
                ),
                onPressed: () {
                  multiPlayerMode = true;
                  Navigator.pushReplacementNamed(context, 'game');
                },
                child: const Text('2 Players'),
              ),

              //single player
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  primary: const Color(0xff00a4aa),
                ),
                onPressed: () {
                  multiPlayerMode = false;
                  Navigator.pushNamed(context, 'game');
                },
                child: const Text('1 player'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
