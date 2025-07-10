import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3目並べ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> board = List.filled(9, '');
  bool isXTurn = true;
  String winner = '';
  bool gameOver = false;

  void _makeMove(int index) {
    if (board[index] != '' || gameOver) return;

    setState(() {
      board[index] = isXTurn ? 'X' : 'O';
      isXTurn = !isXTurn;
      winner = _checkWinner();
      if (winner != '') {
        gameOver = true;
      } else if (!board.contains('')) {
        winner = '引き分け';
        gameOver = true;
      }
    });
  }

  String _checkWinner() {
    // 勝利パターンのチェック
    List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // 横
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // 縦
      [0, 4, 8], [2, 4, 6], // 斜め
    ];

    for (var pattern in winPatterns) {
      if (board[pattern[0]] != '' &&
          board[pattern[0]] == board[pattern[1]] &&
          board[pattern[1]] == board[pattern[2]]) {
        return board[pattern[0]];
      }
    }
    return '';
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      isXTurn = true;
      winner = '';
      gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3目並べ'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.blue.shade100],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ゲーム状態の表示
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    gameOver
                        ? (winner == '引き分け' ? '引き分け!' : '$winner の勝ち!')
                        : '${isXTurn ? 'X' : 'O'} の番',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: gameOver
                          ? Colors.red.shade600
                          : Colors.blue.shade800,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // ゲームボード
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _makeMove(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: board[index] != ''
                                ? (board[index] == 'X'
                                      ? Colors.blue.shade50
                                      : Colors.red.shade50)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              board[index],
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: board[index] == 'X'
                                    ? Colors.blue.shade700
                                    : Colors.red.shade700,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // リセットボタン
            Container(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: _resetGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  '新しいゲーム',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
