import 'package:flutter/material.dart';

import 'package:timer_builder/timer_builder.dart';

import 'package:chess_game/chessLogic/piece.dart';
import 'package:chess_game/chessLogic/empty.dart';
import 'package:chess_game/chessLogic/king.dart';

import 'home.dart';

///false -> semi-white (0xffc3ccc8) player
///true -> black player
bool player = false;
Color playerColor = const Color(0xffc3ccc8);
bool endGame = false;
bool multiPlayerMode = true;

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  GameState createState() => GameState();
}

class GameState extends State<Game> {
  int _time = 0;

  @override
  void initState() {
    super.initState();
    Piece.returnAllPiecesToItsLocations();
    Piece.initializeBlackPiecesMap();
    endGame = false;
  }

  @override
  Widget build(BuildContext context) =>
      //prevent the user from using back button
      WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          //appBar(Timer , Player , Exit)
          appBar: AppBar(
            //Player [completed]
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: player ? Colors.black : Colors.white)),
            ),

            //Timer
            centerTitle: true,
            title: TimerBuilder.periodic(
              const Duration(seconds: 1),
              builder: (context) => Text(
                'Time : ${_time++}',
                style: TextStyle(color: player ? Colors.black : Colors.white),
              ),
            ),

            //Exit
            actions: <Widget>[
              IconButton(
                  tooltip: 'Close the game',
                  icon: const Icon(Icons.close),
                  color: player ? Colors.black : Colors.white,
                  onPressed: () => showExitAlertDialog(context)),
            ],
          ),

          body: Stack(children: <Widget>[
            //background
            Transform.rotate(
              angle: 2.0,
              child: Container(color: player ? Colors.black : Colors.white),
            ),

            //chess board
            Center(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Column(
                  children: <Widget>[
                    _buildRow(8),
                    _buildRow(7),
                    _buildRow(6),
                    _buildRow(5),
                    _buildRow(4),
                    _buildRow(3),
                    _buildRow(2),
                    _buildRow(1),
                  ],
                ),
              ),
            ),

            //after the game end a transparent Container will show up to prevent any movement
            Container(color: endGame ? Colors.transparent : null)
          ]),
        ),
      );

  //show AlertDialog to ensure if the player want to exit the game [completed]
  showExitAlertDialog(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: const Text('Close the game ?'),
      actions: [
        //Press no to return to game page
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'No',
            style: TextStyle(
              color: Color(0xff00a4aa),
            ),
          ),
        ),

        //Press yes to close the game page and return to home page
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
          ),
          onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
          child: const Text(
            'Yes',
            style: TextStyle(
              color: Color(0xff00a4aa),
            ),
          ),
        ),
      ],
    );
    showDialog<AlertDialog>(
        context: context, builder: (context) => alertDialog);
  }

  static showEndGameAlertDialog(BuildContext context, Color winnerColor) {
    String winner =
        winnerColor == Colors.black ? 'Black player' : 'white player';

    SimpleDialog alertDialog = SimpleDialog(
      title: Text('$winner wins', style: TextStyle(color: winnerColor)),
      titlePadding: const EdgeInsets.all(10),
    );

    showDialog<SimpleDialog>(
        context: context, builder: (context) => alertDialog);
  }

  //building a single row in the chessBoard
  //row number must be >= 1  && <= 8
  Row _buildRow(int rowNumber) {
    List<Widget> rowChildren = [];

    //determine the color of the blocks
    //false -> specialBlue , true -> white
    bool blockColor;
    rowNumber % 2 == 0 ? blockColor = true : blockColor = false;

    for (int x = 10; x <= 80; x += 10, blockColor = !blockColor) {
      Piece currentPiece = Piece.allPieces[x + rowNumber]!;
      rowChildren.add(Expanded(
        //width & Height & color of each block
        child: Container(
          height: widthOrHeight,
          width: widthOrHeight,
          color: blockColor ? Colors.white : const Color(0xff00a4aa),

          //each block is dragTarget
          child: DragTarget<Piece>(
            builder: (context, dataList, ignore) {
              //empty block
              if (currentPiece is Empty) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: currentPiece.pieceBackgroundColor,
                      width: 2,
                    ),
                  ),
                );
              }

              // non empty block
              //for multi player game
              else if (multiPlayerMode) {
                return Draggable<Piece>(
                  maxSimultaneousDrags:
                      playerColor == currentPiece.pieceColor ? 1 : 0,
                  data: currentPiece,
                  feedback: currentPiece.pieceImageIcon!,
                  childWhenDragging: Container(),
                  child: Stack(
                    children: [
                      Container(color: currentPiece.pieceBackgroundColor),
                      currentPiece.pieceImageIcon!
                    ],
                  ),
                );
              }
              //for single player game
              else {
                if (currentPiece.pieceColor == const Color(0xffc3ccc8)) {
                  return Draggable<Piece>(
                    maxSimultaneousDrags:
                        playerColor == const Color(0xffc3ccc8) ? 1 : 0,
                    data: currentPiece,
                    feedback: currentPiece.pieceImageIcon!,
                    childWhenDragging: Container(),
                    child: currentPiece.pieceImageIcon!,
                  );
                } else {
                  return Stack(children: <Widget>[
                    Container(color: currentPiece.pieceBackgroundColor),
                    currentPiece.pieceImageIcon!
                  ]);
                }
              }
            },
            onWillAccept: (piece) {
              piece!.movement = piece.generateMovement();

              for (int index in piece.movement!) {
                setState(() =>
                    Piece.allPieces[index]!.pieceBackgroundColor = Colors.red);
              }

              if (piece.movement!.contains(currentPiece.location)) {
                return true;
              } else {
                return false;
              }
            },
            onAccept: (piece) async {
              for (int index in piece.movement!) {
                setState(() => Piece.allPieces[index]!.pieceBackgroundColor =
                    Colors.transparent);
              }

              piece.firstMovement = false;

              //restart the timer
              _time = 0;

              //move the piece to the currentPiece location
              Piece.allPieces[currentPiece.location] = piece;

              if (currentPiece is King) {
                showEndGameAlertDialog(context, piece.pieceColor!);
                setState(() => endGame = true);
              }

              //after the piece move to it's new location
              //convert the piece location(before movement) to Empty
              Piece.allPieces[piece.location] =
                  Empty(piece.xPosition, piece.yPosition);

              //change the piece location (after movement) to the currentPiece location
              piece.updatePieceLocation(
                  currentPiece.xPosition, currentPiece.yPosition);

              setState(() {
                player = !player;
                playerColor = player ? Colors.black : const Color(0xffc3ccc8);
              });

              if (!multiPlayerMode) {
                int firstLocation = Piece.generateRandomMovement(context);
              }
            },
            onLeave: (piece) {
              for (int index in piece!.movement!) {
                setState(() => Piece.allPieces[index]!.pieceBackgroundColor =
                    Colors.transparent);
              }
            },
          ),
        ),
      ));
    }

    return Row(children: rowChildren);
  }
}
