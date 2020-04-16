import 'package:chess/chessLogic/piece.dart';

class Empty extends Piece {
  Empty(int xPosition, yPosition) : super(xPosition, yPosition);

  @override
  List<int> generateMovement() {
    return null;
  }
}
