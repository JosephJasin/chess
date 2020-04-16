//[completed]
import 'package:flutter/material.dart';

import 'package:chess/chessLogic/piece.dart';
import 'package:chess/chessLogic/empty.dart';
import 'package:chess/pages/home.dart' show widthOrHeight;

class Bishop extends Piece {
  Bishop(int xPosition, yPosition, bool player)
      : super(xPosition, yPosition, player) {
    pieceImageIcon = ImageIcon(
      AssetImage('assets/chessIcons/bishop.png'),
      size: widthOrHeight,
      color: pieceColor,
    );

    movement = generateMovement();
  }

  @override
  List<int> generateMovement() {
    List<int> diagonalMovement = List<int>();

    //diagonal movement(from piece location to top-right)
    for (int x = xPosition + 10, y = yPosition + 1;
        x <= 80 && y <= 8;
        x += 10, y++) {
      if (Piece.allPieces[x + y]?.pieceColor == pieceColor) break;
      diagonalMovement.add(x + y);
      if (Piece.allPieces[x + y] is! Empty) break;
    }

    //diagonal movement(from piece location to bottom-left)
    for (int x = xPosition - 10, y = yPosition - 1;
        x >= 10 && y >= 1;
        x -= 10, y--) {
      if (Piece.allPieces[x + y]?.pieceColor == pieceColor) break;
      diagonalMovement.add(x + y);
      if (Piece.allPieces[x + y] is! Empty) break;
    }

    //diagonal movement(from piece location to top-left)
    for (int x = xPosition - 10, y = yPosition + 1;
        x >= 10 && y <= 8;
        x -= 10, y++) {
      if (Piece.allPieces[x + y]?.pieceColor == pieceColor) break;
      diagonalMovement.add(x + y);
      if (Piece.allPieces[x + y] is! Empty) break;
    }

    //diagonal movement(from piece location to bottom-right)
    for (int x = xPosition + 10, y = yPosition - 1;
        x <= 80 && y >= 1;
        x += 10, y--) {
      if (Piece.allPieces[x + y]?.pieceColor == pieceColor) break;
      diagonalMovement.add(x + y);
      if (Piece.allPieces[x + y] is! Empty) break;
    }

    return diagonalMovement;
  }
}
