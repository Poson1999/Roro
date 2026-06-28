import 'package:flutter/material.dart';
import '../models.dart';
import '../quiz_bank.dart';

class GameDialogs {
  // 💡 修正：給 builder 傳入明確的 ctx，確保 Navigator 可以精準關閉它
  static Future<void> showLoadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text("正在抽取命運卡..."),
          ],
        ),
      ),
    );
  }

  static Future<int?> showChoiceDialog(BuildContext context) {
    return showDialog<int>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text("選擇效果："),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed: () => Navigator.pop(ctx, 0), child: const Text("+50 分")),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: () => Navigator.pop(ctx, 1), child: const Text("前進一格")),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: () => Navigator.pop(ctx, 2), child: const Text("倒退兩格")),
          ],
        ),
      ),
    );
  }

  static Future<void> showResultDialog(BuildContext context, String title, String content) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("確定"))
        ],
      ),
    );
  }

  static Future<bool?> showQuizDialog(BuildContext context, int position) {
    int typeIndex = (position / 7).floor().clamp(0, 3);
    List<Quiz>? bank = quizBank[typeIndex];
    if (bank == null || bank.isEmpty) return Future.value(false);

    List<Quiz> shuffledBank = List.from(bank)..shuffle();
    Quiz q = shuffledBank.first;
    List<String> options = List.from(q.options);
    String correct = options[q.correctIndex];
    options.shuffle();

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(["初階", "進階", "專家", "大師"][typeIndex]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(q.text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            ...options.map((opt) => Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx, opt == correct),
                child: Text(opt),
              ),
            )),
          ],
        ),
      ),
    );
  }
}