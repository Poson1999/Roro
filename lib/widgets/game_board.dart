import 'package:flutter/material.dart';
import '../models.dart';
import 'board_background.dart';

class GameBoard extends StatelessWidget {
  final List<Player> players;
  final Player currentPlayer;
  final int diceValue;
  final double boardSize, cellSize;
  final List<Offset> cellPositions;

  const GameBoard({
    super.key,
    required this.players,
    required this.currentPlayer,
    required this.diceValue,
    required this.boardSize,
    required this.cellSize,
    required this.cellPositions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boardSize,
      height: boardSize,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          RepaintBoundary(
            child: StaticBoardBackground(
              cellPositions: cellPositions,
              cellSize: cellSize,
            ),
          ),
          const RepaintBoundary(child: _LogoLayer()),
          ...players.map(_buildPlayer),
          _buildDiceLayer(),
        ],
      ),
    );
  }

  Widget _buildDiceLayer() => Positioned(
    bottom: cellSize * 1.6,
    left: 0,
    right: 0,
    child: Center(
      child: Icon(
        _getDiceIcon(diceValue),
        size: cellSize * 1.0,
        color: currentPlayer.color,
        shadows: const [
          Shadow(color: Colors.white, blurRadius: 2),
          Shadow(color: Colors.black26, blurRadius: 3, offset: Offset(1, 1)),
        ],
      ),
    ),
  );

  IconData _getDiceIcon(int value) {
    const icons = [Icons.looks_one, Icons.looks_two, Icons.looks_3, Icons.looks_4, Icons.looks_5, Icons.looks_6];
    return icons[(value - 1).clamp(0, 5)];
  }

  Widget _buildPlayer(Player p) => AnimatedPositioned(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOut,
    left: cellPositions[p.position].dx + (cellSize * 0.25),
    top: cellPositions[p.position].dy + (cellSize * 0.25),
    child: Container(
      width: cellSize * 0.5,
      height: cellSize * 0.5,
      decoration: BoxDecoration(
        color: p.color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 3)],
      ),
    ),
  );
}

class _LogoLayer extends StatelessWidget {
  const _LogoLayer();
  @override
  Widget build(BuildContext context) => const Center(
    child: Opacity(
      opacity: 0.2,
      // 💡 放大 2 倍字體大小，面積即為 2*2 = 4 倍
      child: Text(
          "RORO",
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 80,
              fontWeight: FontWeight.w900,
              letterSpacing: 2
          )
      ),
    ),
  );
}