import 'package:chess_game/chessLogic/piece.dart';

class Empty extends Piece {
  Empty(int xPosition, yPosition) : super(xPosition, yPosition);

  @override
  List<int>? generateMovement() => null;
}
