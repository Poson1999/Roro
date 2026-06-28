import 'package:flutter/material.dart';

// 玩家模型
class Player {
  final String name;
  final Color color;
  int position;
  int score;
  bool isFinished;
  int arrivalOrder;
  void addScore(int points) {
    score += points;
  }

  Player({
    required this.name,
    required this.color,
    required this.position,
    required this.score,
    required this.isFinished,
    this.arrivalOrder = 999,
  });
}

// 題目模型
class Quiz {
  final String text;
  final List<String> options;
  final int correctIndex;
  Quiz(this.text, this.options, this.correctIndex);
}