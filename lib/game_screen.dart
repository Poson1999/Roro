import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'models.dart';
import 'game_state.dart';
import 'widgets/game_board.dart';
import 'constants/game_constants.dart';
import 'widgets/game_views.dart';
import 'utils/game_event_helper.dart';

class RoroGame extends StatefulWidget {
  final List<Player> players;
  const RoroGame({super.key, required this.players});

  @override
  State<RoroGame> createState() => _RoroGameState();
}

class _RoroGameState extends State<RoroGame> {
  double _cellSize = 0, _boardSize = 0;
  late List<Offset> _cellPositions;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.of(context).size;
    _boardSize = min(size.width, size.height - 150).clamp(0.0, 800.0) - 20;
    _cellSize = _boardSize / 8;
    // 💡 使用 GameConstants.totalCells
    _cellPositions = List.generate(GameConstants.totalCells, (i) => _calculateOffset(i, _cellSize));
  }

  Offset _calculateOffset(int i, double size) {
    if (i < 7) return Offset(i * size, 0);
    if (i < 14) return Offset(7 * size, (i - 7) * size);
    if (i < 21) return Offset((7 - (i - 14)) * size, 7 * size);
    return Offset(0, (7 - (i - 21)) * size);
  }

  @override
  Widget build(BuildContext context) {
    // 💡 監聽狀態
    final gameState = context.watch<GameState>();

    if (gameState.isGameOver) return GameOverView(players: gameState.players);

    return Scaffold(
      appBar: AppBar(title: Text("輪到：${gameState.currentPlayer.name}")),
      body: Column(children: [
        Expanded(child: Center(child: GameBoard(
            players: gameState.players, currentPlayer: gameState.currentPlayer,
            diceValue: gameState.diceValue, boardSize: _boardSize,
            cellSize: _cellSize, cellPositions: _cellPositions
        ))),
        ScoreBoardView(players: gameState.players),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: gameState.isMoving ? null : () async {
          final state = context.read<GameState>();
          final int finalPos = await state.rollDice();
          if (!mounted) return;
          if (finalPos != -1) {
            await GameEventHelper.process(context, finalPos);
          }
          if (!mounted) return;
          state.nextTurn();
        },
        label: const Text("擲骰子！"),
      ),
    );
  }
}