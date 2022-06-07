//[completed]
import 'package:chess_game/chessLogic/empty.dart';
import 'package:flutter/material.dart';

import 'package:chess_game/chessLogic/piece.dart';
import 'package:chess_game/pages/home.dart' show widthOrHeight;

class Pawn extends Piece {
  Pawn(int xPosition, yPosition, bool player)
      : super(xPosition, yPosition, player) {
    pieceImageIcon = ImageIcon(
      const AssetImage('assets/chessIcons/pawn.png'),
      color: pieceColor,
      size: widthOrHeight,
    );

    movement = generateMovement();
  }

  @override
  List<int> generateMovement() {
    List<int> movementList = [];

    //if the pawn is white
    if (pieceColor == const Color(0xffc3ccc8)) {
      //moving up
      if (yPosition + 1 <= 8 &&
          Piece.allPieces[xPosition + yPosition + 1] is Empty) {
        movementList.add(xPosition + yPosition + 1);
        if (firstMovement &&
            Piece.allPieces[xPosition + yPosition + 2] is Empty) {
          movementList.add(xPosition + yPosition + 2);
        }
      }

      //attack up-right
      if (Piece.allPieces[xPosition + 10 + yPosition + 1]?.pieceColor ==
          Colors.black) movementList.add(xPosition + 10 + yPosition + 1);

      //attack up-left
      if (Piece.allPieces[xPosition - 10 + yPosition + 1]?.pieceColor ==
          Colors.black) movementList.add(xPosition - 10 + yPosition + 1);
    }
    //if the pawn is black
    else {
      //moving down
      if (yPosition - 1 >= 1 &&
          Piece.allPieces[xPosition + yPosition - 1] is Empty) {
        movementList.add(xPosition + yPosition - 1);
        if (firstMovement &&
            Piece.allPieces[xPosition + yPosition - 2] is Empty) {
          movementList.add(xPosition + yPosition - 2);
        }
      }
      //attack down-right
      if (Piece.allPieces[xPosition + 10 + yPosition - 1]?.pieceColor ==
          const Color(0xffc3ccc8)) {
        movementList.add(xPosition + 10 + yPosition - 1);
      }

      //attack down-left
      if (Piece.allPieces[xPosition - 10 + yPosition - 1]?.pieceColor ==
          const Color(0xffc3ccc8)) {
        movementList.add(xPosition - 10 + yPosition - 1);
      }
    }
    return movementList;
  }
}
