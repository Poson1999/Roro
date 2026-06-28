import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../game_state.dart';
import '../widgets/game_dialogs.dart';
import 'game_event_helper.dart';
import '../constants/game_constants.dart';

class CardEffectHandler {
  static Future<void> handle(BuildContext context, {required bool isFate}) async {
    final state = context.read<GameState>();
    if (isFate) {
      GameDialogs.showLoadingDialog(context);
      await Future.delayed(const Duration(milliseconds: 1200));
      if (!context.mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
    }

    final choice = isFate ? Random().nextInt(3) : (await GameDialogs.showChoiceDialog(context) ?? 0);
    if (!context.mounted) return;

    final pIdx = state.currentPlayerIndex;
    if (choice == 2 && (state.retreatCount[pIdx] ?? 0) >= 2) {
      await GameDialogs.showResultDialog(context, isFate ? "命運" : "機會", "無法再後退，改為獲得 +50 分！");
      if (context.mounted) state.updatePlayerScore(50);
      return;
    }

    if (choice == 0) {
      await GameDialogs.showResultDialog(context, isFate ? "命運" : "機會", "獲得 +50 分！");
      if (context.mounted) state.updatePlayerScore(50);
    } else {
      final isForward = (choice == 1);
      final steps = isForward ? 1 : 2;
      await GameDialogs.showResultDialog(context, isFate ? "命運" : "機會", isForward ? "前進一格！" : "倒退兩格！");

      for (int i = 0; i < steps; i++) {
        await Future.delayed(const Duration(milliseconds: 400));
        if (!context.mounted) return;
        state.movePlayer(isForward ? 1 : -1);
      }

      if (!isForward) state.retreatCount[pIdx] = (state.retreatCount[pIdx] ?? 0) + 1;

      if (!context.mounted) return;
      final finalPos = state.currentPlayer.position;
      if (!GameConstants.specialTiles.contains(finalPos)) {
        await GameEventHelper.runQuizFlow(context, finalPos);
      }
    }
  }
}