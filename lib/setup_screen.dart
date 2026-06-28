import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import 'game_screen.dart';
import 'game_state.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int _playerCount = 2;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _updateControllers(2);
  }

  void _updateControllers(int count) {
    _controllers = List.generate(count, (i) => TextEditingController(text: "玩家 ${i + 1}"));
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startGame() {
    final List<Player> players = List.generate(_playerCount, (i) {
      final name = _controllers[i].text.trim().isEmpty
          ? "玩家 ${i + 1}"
          : _controllers[i].text.trim();

      return Player(
        name: name,
        color: Colors.primaries[i % Colors.primaries.length],
        position: 0,
        score: 0,
        isFinished: false,
      );
    });

    // 💡 使用 Provider 注入玩家資料
    final state = context.read<GameState>();
    state.players.clear();
    state.players.addAll(players);

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoroGame(players: players),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("設定遊戲", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(24.0)
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.group, size: 28, color: Colors.indigo),
                    const SizedBox(width: 10),
                    Text(
                      "玩家人數: $_playerCount 人",
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),
                    ),
                  ],
                ),
                Slider(
                  value: _playerCount.toDouble(),
                  min: 1,
                  max: 8,
                  divisions: 7,
                  label: "$_playerCount 人",
                  onChanged: (val) {
                    setState(() {
                      _playerCount = val.toInt();
                      _updateControllers(_playerCount);
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _playerCount,
              itemBuilder: (context, index) {
                final inputColor = Colors.primaries[index % Colors.primaries.length];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: _controllers[index],
                    decoration: InputDecoration(
                      labelText: "玩家 ${index + 1} 名稱",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                      prefixIcon: Icon(Icons.person, color: inputColor),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _startGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                ),
                child: const Text("開始遊戲", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}