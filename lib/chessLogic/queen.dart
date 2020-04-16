//[completed]
import 'package:flutter/material.dart';

import 'package:chess/chessLogic/piece.dart';
import 'package:chess/chessLogic/empty.dart';
import 'package:chess/pages/home.dart' show widthOrHeight;


class Queen extends Piece {

  Queen(int xPosition, yPosition, bool player)
      : super(xPosition, yPosition, player) {
    pieceImageIcon = ImageIcon(
      AssetImage('assets/chessIcons/queen.png'),
      color: pieceColor,
      size: widthOrHeight,
    );
    movement = generateMovement();
  }

  @override
  List<int> generateMovement() {
    List<int> movementList = List<int>();

    //moving up
    for (int y = yPosition + 1; y <= 8; y++) {
      if (Piece.allPieces[xPosition + y]?.pieceColor == pieceColor) break;
      movementList.add(xPosition + y);
      if (Piece.allPieces[xPosition + y] is! Empty) break;
    }

    //moving down
    for (int y = yPosition - 1; y >= 1; y--) {
      if (Piece.allPieces[xPosition + y]?.pieceColor == pieceColor) break;
      movementList.add(xPosition + y);
      if (Piece.allPieces[xPosition + y] is! Empty) break;
    }

    //moving right
    for (int x = xPosition + 10; x <= 80; x += 10) {
      if (Piece.allPieces[x + yPosition]?.pieceColor == pieceColor) break;
      movementList.add(x + yPosition);
      if (Piece.allPieces[x + yPosition] is! Empty) break;
    }

    //moving left
    for (int x = xPosition - 10; x >= 10; x -= 10) {
      if (Piece.allPieces[x + yPosition]?.pieceColor == pieceColor) break;
      movementList.add(x + yPosition);
      if (Piece.allPieces[x + yPosition] is! Empty) break;
    }

    //diagonal movement(from piece location to top-right)
    for (int x = xPosition + 10, y = yPosition + 1;
    x <= 80 && y <= 8;
    x += 10, y++) {
      if (Piece.allPieces[x + y]?.pieceColor == pieceColor) break;
      movementList.add(x + y);
      if (Piece.allPieces[x + y] is! Empty) break;
    }

    //diagonal movement(from piece location to bottom-left)
    for (int x = xPosition - 10, y = yPosition - 1;
    x >= 10 && y >= 1;
    x -= 10, y--) {
      if (Piece.allPieces[x + y]?.pieceColor == pieceColor) break;
      movementList.add(x + y);
      if (Piece.allPieces[x + y] is! Empty) break;
    }

    //diagonal movement(from piece location to top-left)
    for (int x = xPosition - 10, y = yPosition + 1;
    x >= 10 && y <= 8;
    x -= 10, y++) {
      if (Piece.allPieces[x + y]?.pieceColor == pieceColor) break;
      movementList.add(x + y);
      if (Piece.allPieces[x + y] is! Empty) break;
    }

    //diagonal movement(from piece location to bottom-right)
    for (int x = xPosition + 10, y = yPosition - 1;
    x <= 80 && y >= 1;
    x += 10, y--) {
      if (Piece.allPieces[x + y]?.pieceColor == pieceColor) break;
      movementList.add(x + y);
      if (Piece.allPieces[x + y] is! Empty) break;
    }
    return movementList;
  }
}
