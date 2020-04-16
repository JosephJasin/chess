import 'package:flutter/material.dart';

import 'package:chess/pages/game.dart';

import 'king.dart';
import 'queen.dart';
import 'rock.dart';
import 'bishop.dart';
import 'knight.dart';
import 'pawn.dart';
import 'empty.dart';

abstract class Piece {
  ///player = false -> semi-white (0xffc3ccc8) player
  ///
  ///player = true  -> black player
  Piece(int xPosition, yPosition, [bool player]) {
    this.xPosition = xPosition;
    this.yPosition = yPosition;
    this.location = xPosition + yPosition;
    // player = null when we create Empty object -> pieceColor = null
    if (player != null)
      this.pieceColor = player ? Color(0xff000000) : Color(0xffc3ccc8);
  }

  ///the x position of the piece represented as :
  ///10 ,20 ,30 ,40 ,50 ,60 ,70 ,80 .
  int xPosition;

  ///the y position of the piece represented as :
  ///1 , 2, 3, 4, 5, 6, 7, 8 .
  int yPosition;

  ///location of the piece = x + y .
  int location;

  ///semi-white (0xffc3ccc8) or black
  Color pieceColor;

  ///The widget that represent the piece
  Widget pieceImageIcon;

  ///used only for pawn only
  bool firstMovement = true;

  ///each key in the map represent the location of one piece.
  ///each value in the map represent the piece that dominate the location(key).
  static Map<int, Piece> allPieces = Map<int, Piece>();

  static List<Piece> blackPieces = List<Piece>();

  ///determine the locations where the piece can move to
  List<int> movement;

  ///initialize the movement of the piece
  List<int> generateMovement();

  Color pieceBackgroundColor = Colors.transparent;

  ///return all pieces to it's origin location in the [Piece.allPieces] map
  static Map<int, Piece> returnAllPiecesToItsLocations() {
    player = false;
    playerColor = Color(0xffc3ccc8);

    //clear all the pieces between the white and black players
    for (int x = 10; x <= 80; x += 10)
      for (int y = 3; y <= 6; y++) Piece.allPieces[x + y] = Empty(x, y);

    //First line for white player
    Piece.allPieces[11] = Rock(10, 1, false);
    Piece.allPieces[21] = Knight(20, 1, false);
    Piece.allPieces[31] = Bishop(30, 1, false);
    Piece.allPieces[41] = King(40, 1, false);
    Piece.allPieces[51] = Queen(50, 1, false);
    Piece.allPieces[61] = Bishop(60, 1, false);
    Piece.allPieces[71] = Knight(70, 1, false);
    Piece.allPieces[81] = Rock(80, 1, false);

    //second line for white player
    for (int x = 10; x <= 80; x += 10) {
      Piece.allPieces[x + 2] = Pawn(x, 2, false);
    }

    //First line for black player
    Piece.allPieces[18] = Rock(10, 8, true);
    Piece.allPieces[28] = Knight(20, 8, true);
    Piece.allPieces[38] = Bishop(30, 8, true);
    Piece.allPieces[48] = Queen(40, 8, true);
    Piece.allPieces[58] = King(50, 8, true);
    Piece.allPieces[68] = Bishop(60, 8, true);
    Piece.allPieces[78] = Knight(70, 8, true);
    Piece.allPieces[88] = Rock(80, 8, true);

    //second line for black player
    for (int x = 10; x <= 80; x += 10) {
      Piece.allPieces[x + 7] = Pawn(x, 7, true);
    }

    return Piece.allPieces;
  }

  ///update Piece location than update movement
  updatePieceLocation(int newX, int newY) {
    this.xPosition = newX;
    this.yPosition = newY;
    this.location = xPosition + yPosition;
  }

  static initializeBlackPiecesMap() {
    blackPieces = List<Piece>();
    for (Piece piece in allPieces.values)
      if (piece?.pieceColor == Colors.black) blackPieces.add(piece);
  }

  ///Random movement for black player (single player mode)
  ///[multiPlayerMode] must = false
  static int generateRandomMovement(BuildContext context) {
    int firstLocation ;

    //shuffle blackPieces list to get random arrangement
    blackPieces.shuffle();

    //iterate over blackPieces list and find the first piece that can move (piece.movement > 0)
    //than move the piece
    for (int i = 0; i < blackPieces.length && !endGame; i++) {
      //the piece that we want to know if it's can move
      Piece piece = blackPieces[i];
      piece.movement = piece.generateMovement();

      if (piece.movement.length > 0) {
        //shuffle the movement list to get random arrangement
        piece.movement.shuffle();
        firstLocation = piece.location;
        //replace the location of the piece (before moving) to empty
        allPieces[piece.location] = Empty(piece.xPosition, piece.yPosition);

        if (allPieces[piece.movement.first] is King) {
          GameState.showEndGameAlertDialog (context , piece.pieceColor);
          endGame = true;
        }

        //replace the target location to the piece location
        allPieces[piece.movement.first] = piece;

        int x = int.parse(piece.movement.first.toString().substring(0, 1)) * 10;
        int y = int.parse(piece.movement.first.toString().substring(1, 2));
        piece.updatePieceLocation(x, y);
        blackPieces[i] = piece;
        break;
      }
    }

    player = false;
    playerColor = Color(0xffc3ccc8);

    return firstLocation;
  }
}
