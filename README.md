# Roro Game

這是一款基於 Flutter 開發的互動式桌遊，結合了擲骰子、機會命運與層級化題庫系統。玩家需從起點出發，目標是準確回到終點以完成遊戲並進行最終評分。

## 遊戲規則

1. 遊戲目標
   每位玩家輪流擲骰子，在棋盤上移動。遊戲目標是抵達終點並獲得高分。
2. 移動邏輯
   玩家輪流擲骰子，依據骰子點數（1-6 點）移動棋子，玩家在移動過程中將會觸發對應場景的題目。
3. 格子機制
   一般：停留時會觸發對應場景（目前Sample為：初階、進階、專家、大師）的隨機題目。
   答對：獲得 100 分。
   答錯：獲得 50 分。
   命運：觸發抽取動畫，隨機獲得加分、前進或後退效果。若倒退兩格次數超過兩次，系統將強制抽取 +50 分以平衡遊戲。
   機會：直接觸發選擇介面，可由玩家決定加分或移動位置。
4. 遊戲結束
   當所有玩家都成功抵達終點並完成最後作答後，系統將計算所有玩家的總分並顯示最終排名。

# Roro Game

Roro Game is an interactive board game built with Flutter that combines dice-rolling, Chance & Fate mechanics, and a hierarchical question bank system. Players start from the beginning and must reach the exact finish line to complete the game and receive their final score.

## Game Rules

1. Game Objective
   Players take turns rolling dice to move across the board. The goal is to reach the finish line and accumulate the highest possible score.
2. Movement Logic
   Players roll a die (1–6) in turn and move their pieces accordingly. Landing on specific tiles will trigger questions based on the game's difficulty levels (Sample levels: Beginner, Intermediate, Advanced, and Master).
3. Tile Mechanics
   Normal Tile: Landing here triggers a random question from the current scene’s difficulty level.
   Correct Answer: +100 points.
   Incorrect Answer: +50 points.
   Destiny: Triggers an animation to randomly grant a point bonus, move the player forward, or force them backward. If a player is forced to move backward more than twice, the system will automatically trigger a "+50 points" reward to balance the gameplay.
   Chance: Opens a selection interface allowing the player to choose between gaining points or moving their piece to a different position.
4. Game Completion
   Once all players have reached the finish line and completed their final question, the system will calculate the total scores for all participants and display the final rankings.

# GitHub

https://github.com/Poson1999/Roro.git

# Play Online

https://roro-jet.vercel.app?_vercel_share=88p8AXX8wChHpjWhQREIB1kaN8Uez73v
