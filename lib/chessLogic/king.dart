//[completed]
import 'package:chess/chessLogic/empty.dart';
import 'package:flutter/material.dart';

import 'package:chess/chessLogic/piece.dart';
import 'package:chess/pages/home.dart' show widthOrHeight;

class King extends Piece {
  King(int xPosition, yPosition, bool player)
      : super(xPosition, yPosition, player) {
    pieceImageIcon = ImageIcon(
      AssetImage('assets/chessIcons/king.png'),
      color: pieceColor,
      size: widthOrHeight,
    );

    movement = generateMovement();
  }

  @override
  List<int> generateMovement() {
    List<int> movementList = List<int>();

    //vertical movement (up and down)
    if (yPosition + 1 <= 8 &&
        !(Piece.allPieces[xPosition + yPosition + 1]?.pieceColor == pieceColor))
      movementList.add(xPosition + yPosition + 1);
    if (yPosition - 1 >= 1 &&
        !(Piece.allPieces[xPosition + yPosition - 1]?.pieceColor == pieceColor))
      movementList.add(xPosition + yPosition - 1);

    //horizontal movement
    if (xPosition + 10 <= 80) {
      if (!(Piece.allPieces[xPosition + 10 + yPosition]?.pieceColor ==
          pieceColor)) movementList.add(xPosition + 10 + yPosition);
      //diagonal movement
      if (yPosition + 1 <= 8 &&
          !(Piece.allPieces[xPosition + 10 + yPosition + 1]?.pieceColor ==
              pieceColor)) movementList.add(xPosition + 10 + yPosition + 1);
      if (yPosition - 1 >= 1 &&
          !(Piece.allPieces[xPosition + 10 + yPosition - 1]?.pieceColor ==
              pieceColor)) movementList.add(xPosition + 10 + yPosition - 1);
    }

    if (xPosition - 10 >= 10) {
      if (!(Piece.allPieces[xPosition - 10 + yPosition]?.pieceColor ==
          pieceColor)) movementList.add(xPosition - 10 + yPosition);
      //diagonal movement
      if (yPosition + 1 <= 8 &&
          !(Piece.allPieces[xPosition - 10 + yPosition + 1]?.pieceColor ==
              pieceColor)) movementList.add(xPosition - 10 + yPosition + 1);
      if (yPosition - 1 >= 1 &&
          !(Piece.allPieces[xPosition - 10 + yPosition - 1]?.pieceColor ==
              pieceColor)) movementList.add(xPosition - 10 + yPosition - 1);
    }

    return movementList;
  }
}
