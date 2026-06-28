import 'package:flutter/material.dart';
import '../models.dart';
import '../setup_screen.dart';

class ScoreBoardView extends StatelessWidget {
  final List<Player> players;
  const ScoreBoardView({super.key, required this.players});

  @override
  Widget build(BuildContext context) => Container(
    height: 100, color: Colors.grey.withValues(alpha: 0.1),
    child: ListView.builder(
      scrollDirection: Axis.horizontal, itemCount: players.length,
      itemBuilder: (ctx, i) => SizedBox(width: 90, child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, color: players[i].color),
          Text(players[i].name, overflow: TextOverflow.ellipsis),
          Text("${players[i].score} 分"),
        ],
      )),
    ),
  );
}

class GameOverView extends StatelessWidget {
  final List<Player> players;
  const GameOverView({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    final sorted = List.from(players)..sort((a, b) => b.score.compareTo(a.score));
    return Scaffold(body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("遊戲結束", style: TextStyle(fontSize: 28)),
      ...sorted.map((p) => Text("${p.name}: ${p.score} 分")),
      const SizedBox(height: 20),
      ElevatedButton(
          onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const SetupScreen()), (r) => false),
          child: const Text("回到首頁")
      ),
    ])));
  }
}