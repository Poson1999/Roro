import 'package:flutter/material.dart';

class StaticBoardBackground extends StatelessWidget {
  final List<Offset> cellPositions;
  final double cellSize;

  const StaticBoardBackground({super.key, required this.cellPositions, required this.cellSize});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(28, (i) => BoardCell(
        position: cellPositions[i],
        size: cellSize,
        index: i,
      )),
    );
  }
}

class BoardCell extends StatelessWidget {
  final Offset position;
  final double size;
  final int index;

  const BoardCell({super.key, required this.position, required this.size, required this.index});

  @override
  Widget build(BuildContext context) {
    final isFate = (index == 7 || index == 21);
    final isChance = (index == 14);
    final isGoal = (index == 0);

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Container(
        width: size, height: size,
        padding: const EdgeInsets.all(3.0),
        child: Container(
          decoration: BoxDecoration(
            color: isFate ? const Color(0xFFFEF3C7) : (isChance ? const Color(0xFFDBEAFE) : (isGoal ? const Color(0xFF4A5568) : Colors.white)),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 2)],
          ),
          child: Center(child: _buildIcon()),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (index == 0) return Icon(Icons.flag_rounded, size: size * 0.5, color: Colors.white);
    if (index == 7 || index == 21) return Icon(Icons.auto_awesome_rounded, size: size * 0.5, color: const Color(0xFFD97706));
    if (index == 14) return Icon(Icons.lightbulb_rounded, size: size * 0.5, color: const Color(0xFF2563EB));
    return const SizedBox.shrink();
  }
}