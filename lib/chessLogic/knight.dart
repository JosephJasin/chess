//[completed]
import 'package:flutter/material.dart';

import 'package:chess/chessLogic/piece.dart';
import 'package:chess/pages/home.dart' show widthOrHeight;

class Knight extends Piece {
  Knight(int xPosition, yPosition, bool player)
      : super(xPosition, yPosition, player) {
    pieceImageIcon = ImageIcon(
      AssetImage('assets/chessIcons/knight.png'),
      color: pieceColor,
      size: widthOrHeight,
    );
    movement = generateMovement();
  }

  @override
  List<int> generateMovement() {
    List<int> movementList = List<int>();

    //moving to top-right
    if (xPosition + 20 <= 80 &&
        yPosition + 1 <= 8 &&
        !(Piece.allPieces[xPosition + 20 + yPosition + 1]?.pieceColor ==
            pieceColor)) movementList.add(xPosition + 20 + yPosition + 1);
    if (xPosition + 10 <= 80 &&
        yPosition + 2 <= 8 &&
        !(Piece.allPieces[xPosition + 10 + yPosition + 2]?.pieceColor ==
            pieceColor)) movementList.add(xPosition + 10 + yPosition + 2);

    //moving to top-left
    if (xPosition - 20 >= 10 &&
        yPosition + 1 <= 8 &&
        !(Piece.allPieces[xPosition - 20 + yPosition + 1]?.pieceColor ==
            pieceColor)) movementList.add(xPosition - 20 + yPosition + 1);
    if (xPosition - 10 >= 10 &&
        yPosition + 2 <= 8 &&
        !(Piece.allPieces[xPosition - 10 + yPosition + 2]?.pieceColor ==
            pieceColor)) movementList.add(xPosition - 10 + yPosition + 2);

    //moving to bottom-right
    if (xPosition + 20 <= 80 &&
        yPosition - 1 >= 1 &&
        !(Piece.allPieces[xPosition + 20 + yPosition - 1]?.pieceColor ==
            pieceColor)) movementList.add(xPosition + 20 + yPosition - 1);
    if (xPosition + 10 <= 80 &&
        yPosition - 2 >= 1 &&
        !(Piece.allPieces[xPosition + 10 + yPosition - 2]?.pieceColor ==
            pieceColor)) movementList.add(xPosition + 10 + yPosition - 2);

    //moving to bottom-left
    if (xPosition - 20 >= 10 &&
        yPosition - 1 >= 1 &&
        !(Piece.allPieces[xPosition - 20 + yPosition - 1]?.pieceColor ==
            pieceColor)) movementList.add(xPosition - 20 + yPosition - 1);
    if (xPosition - 10 >= 10 &&
        yPosition - 2 >= 1 &&
        !(Piece.allPieces[xPosition - 10 + yPosition - 2]?.pieceColor ==
            pieceColor)) movementList.add(xPosition - 10 + yPosition - 2);

    return movementList;
  }
}
