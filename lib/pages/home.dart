import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'game.dart' show multiPlayerMode;

//determine the height and the width of the chess icons
double widthOrHeight;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {






  @override
  Widget build(BuildContext context) {
    //make the app only portrait [completed]
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    widthOrHeight = MediaQuery.of(context).size.width/8;


    return Scaffold(
      //appBar [completed]
      appBar: AppBar(
        title: Text('Chess'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.brightness_3),
            onPressed: () {
              //change between light - dark mode
            },
          )
        ],
      ),

      //drawer(change theme - turn off-on music - facebook page) []
      drawer: Drawer(
        child: Container(
          color: Color(0xff00a4aa),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50.0),

              //turn off-on music [completed]
//              Row(
//                children: <Widget>[
//                  Text('     Music ',
//                      style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 20.0,
//                        fontWeight: FontWeight.w600,
//                      )),
//                  Switch(
//                    activeColor: Colors.black,
//                    value: isMusicOn,
//                    onChanged: (value) {
//                      setState(()=> isMusicOn = value);
//                      value ? advancedPlayer.resume() : advancedPlayer.pause();
//                    },
//                  ),
//                ],
//              ),
            ],
          ),
        ),
      ),

      //body(start button + credits button + chess background) [completed]

      body: Container(
        //Wallpaper [completed]
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/chessWallpaper/wallpaper-1.jpg'),
                fit: BoxFit.cover)),

        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //go to game page (multi player) [completed]
              RaisedButton(
                elevation: 50.0,
                child: Text('2 Players'),
                onPressed: () {
                  multiPlayerMode = true;
                  Navigator.pushReplacementNamed(context, 'game');
                }
              ),

              //go to credit page (single player) [completed]
              RaisedButton(
                elevation: 10.0,
                child: Text('1 player'),
                onPressed: () {
                  multiPlayerMode = false;
                  Navigator.pushNamed(context, 'game');

                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
