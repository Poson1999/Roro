import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'constants/game_constants.dart';
import 'models.dart';

class GameState extends ChangeNotifier {
  final List<Player> players;
  int currentPlayerIndex = 0;
  int diceValue = 1;
  bool isMoving = false;
  bool isGameOver = false;
  final Map<int, int> retreatCount = {};
  final AudioPlayer _audioPlayer = AudioPlayer();

  GameState({required this.players}) {
    for (int i = 0; i < players.length; i++) {
      retreatCount[i] = 0;
    }
  }

  Player get currentPlayer => players[currentPlayerIndex];

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void movePlayer(int steps) {
    int newPos = (currentPlayer.position + steps + GameConstants.totalCells) % GameConstants.totalCells;
    currentPlayer.position = newPos;
    notifyListeners();
  }

  void updatePlayerScore(int points) {
    currentPlayer.score += points;
    notifyListeners();
  }

  void nextTurn() {
    currentPlayerIndex = (currentPlayerIndex + 1) % players.length;
    notifyListeners();
  }

  Future<int> rollDice() async {
    if (isMoving) return -1;
    isMoving = true;
    notifyListeners();

    try {
      await _audioPlayer.play(AssetSource('sounds/dice_roll.mp3'));
    } catch (e) {
      debugPrint("音效播放失敗: $e");
    }

    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      diceValue = Random().nextInt(6) + 1;
      notifyListeners();
    }

    for (int i = 0; i < diceValue; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      movePlayer(1);
      if (currentPlayer.position == GameConstants.goalTile) break;
    }

    isMoving = false;
    notifyListeners();

    return currentPlayer.position;
  }
}