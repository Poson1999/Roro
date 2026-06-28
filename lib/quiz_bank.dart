import 'models.dart';

final Map<int, List<Quiz>> quizBank = {
  0: [
    Quiz("Dart 的副檔名是什麼？", [".dart", ".js", ".py", ".cpp"], 0),
    Quiz("1 + 1 = ?",["2", "3", "4", "5"], 0),
  ],
  1: [
    Quiz("Flutter 用哪種語言編寫？", ["Dart", "Swift", "Java", "Kotlin"], 0),
    Quiz("1 + 8 = ?",["9", "3", "4", "5"], 0),
  ],
  2: [
    Quiz("用來顯示文字的 Widget 是？", ["Text", "Image", "Container", "Row"], 0),
    Quiz("1 + 6 = ?",["7", "3", "4", "5"], 0),
  ],
  3: [
    Quiz("以下哪個不是基本型別？", ["List", "int", "String", "bool"], 0),
    Quiz("10 + 1 = ?",["11", "3", "4", "5"], 0),
  ],
};