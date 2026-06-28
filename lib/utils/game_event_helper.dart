import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../game_state.dart';
import '../widgets/game_dialogs.dart';
import 'card_effect_handler.dart';
import '../constants/game_constants.dart';

class GameEventHelper {
  static bool _isProcessing = false;
  static Future<void> runQuizFlow(BuildContext context, int pos) async {
    final state = context.read<GameState>();
    final isCorrect = await GameDialogs.showQuizDialog(context, pos);
    if (!context.mounted) return;
    final int score = (isCorrect ?? false) ? 100 : 50;
    state.updatePlayerScore(score);
    await GameDialogs.showResultDialog(
        context,
        "答題結果",
        (isCorrect ?? false) ? "答對了！\n+100 分" : "答錯了～\n+50 分"
    );
  }
  static Future<void> process(BuildContext context, int pos) async {
    if (_isProcessing) return;
    _isProcessing = true;

    final state = context.read<GameState>();

    try {
      if (pos == GameConstants.goalTile) {
        await runQuizFlow(context, pos);
        if (!context.mounted) return;
        state.currentPlayer.isFinished = true;
        state.currentPlayer.arrivalOrder = state.players.where((p) => p.isFinished).length;
        await GameDialogs.showResultDialog(context, "遊戲完成", "恭喜抵達終點！");

      } else if (GameConstants.specialTiles.contains(pos)) {
        final bool isFate = (pos != GameConstants.chanceTile);
        await CardEffectHandler.handle(context, isFate: isFate);

      } else {
        await runQuizFlow(context, pos);
      }
    } finally {
      _isProcessing = false;
    }
  }
}