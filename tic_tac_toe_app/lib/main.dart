import 'package:flutter/material.dart';
import 'dart:math';

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
      home: const GameModeSelection(),
    );
  }
}

class GameModeSelection extends StatelessWidget {
  const GameModeSelection({super.key});

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ゲームモードを選択',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 50),
              _buildModeButton(
                context,
                '人 vs 人',
                Icons.people,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TicTacToeGame(isVsComputer: false),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildModeButton(
                context,
                '人 vs コンピュータ',
                Icons.computer,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TicTacToeGame(isVsComputer: true),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        minimumSize: const Size(250, 80),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 30),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key, required this.isVsComputer});

  final bool isVsComputer;

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

    // コンピュータのターン
    if (widget.isVsComputer && !gameOver && !isXTurn) {
      _makeComputerMove();
    }
  }

  void _makeComputerMove() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (gameOver) return;

      int bestMove = _getBestMove();
      setState(() {
        board[bestMove] = 'O';
        isXTurn = true;
        winner = _checkWinner();
        if (winner != '') {
          gameOver = true;
        } else if (!board.contains('')) {
          winner = '引き分け';
          gameOver = true;
        }
      });
    });
  }

  int _getBestMove() {
    int bestScore = -1000;
    int bestMove = 0;

    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        board[i] = 'O';
        int score = _minimax(board, 0, false);
        board[i] = '';
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }
    return bestMove;
  }

  int _minimax(List<String> board, int depth, bool isMaximizing) {
    String result = _checkWinner();
    if (result == 'O') return 10 - depth;
    if (result == 'X') return depth - 10;
    if (!board.contains('')) return 0;

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < 9; i++) {
        if (board[i] == '') {
          board[i] = 'O';
          int score = _minimax(board, depth + 1, false);
          board[i] = '';
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < 9; i++) {
        if (board[i] == '') {
          board[i] = 'X';
          int score = _minimax(board, depth + 1, true);
          board[i] = '';
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
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
                        : widget.isVsComputer
                            ? (isXTurn ? 'あなたの番 (X)' : 'コンピュータの番 (O)')
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
                        color: Colors.black.withValues(alpha: 0.1),
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
                        onTap: widget.isVsComputer && !isXTurn
                            ? null
                            : () => _makeMove(index),
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
