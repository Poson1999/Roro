import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';
import 'setup_screen.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => GameState(players: []),
    child: const MaterialApp(home: SetupScreen()),
  ),
);