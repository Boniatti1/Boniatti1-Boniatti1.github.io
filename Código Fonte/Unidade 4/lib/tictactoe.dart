import 'dart:math';

import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  TicTacToeState createState() => TicTacToeState();
}

class TicTacToeState extends State<TicTacToe> {
  String currentPlayer = "X";
  List<String> currentTable = List.filled(9, '');
  String computer = "O";
  String player = "X";
  String player2 = "O";
  bool vsIA = true; 

  final List<List<int>> victoryPositions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  bool winCheck(String player, List<String> board) {
    for (var victoryCase in victoryPositions) {
      if (board[victoryCase[0]] == player &&
          board[victoryCase[1]] == player &&
          board[victoryCase[2]] == player) {
        return true;
      }
    }
    return false;
  }

  bool isFull(List<String> board) {
    return !board.contains("");
  }

  int minimax(List<String> board, bool isMaximizing, String currentPlayer) {
    if (winCheck(computer, board)) return 10;
    if (winCheck(player, board)) return -10;
    if (isFull(board)) return 0;

    String nextPlayer = currentPlayer == "X" ? "O" : "X";
    int bestScore = isMaximizing ? -1000 : 1000;

    for (int i = 0; i < 9; i++) {
      if (board[i] == "") {
        board[i] = currentPlayer;
        int score = minimax(board, !isMaximizing, nextPlayer);
        board[i] = "";
        if (isMaximizing) {
          bestScore = score > bestScore ? score : bestScore;
        } else {
          bestScore = score < bestScore ? score : bestScore;
        }
      }
    }
    return bestScore;
  }

  int bestMove() {
    int move = -1;
    int bestScore = -1000;

    for (int i = 0; i < 9; i++) {
      if (currentTable[i] == "") {
        currentTable[i] = computer;
        int score = minimax(currentTable, false, player);
        currentTable[i] = "";
        if (score > bestScore) {
          bestScore = score;
          move = i;
        }
      }
    }
    return move;
  }

  void iaMove() {
    int move;
    int percentage = Random().nextInt(100);
    if (percentage < 85) {
      move = bestMove();
    } else {
      var choices = [];
      for (int i = 0; i < 9; i++) {
        if (currentTable[i] == "") {
          choices.add(i);
        }
      }
      move = choices[Random().nextInt(choices.length)];
    }

    if (move != -1) {
      setState(() {
        currentTable[move] = computer;
        if (winCheck(computer, currentTable)) {
          showResult("O computador ganhou");
        } else if (isFull(currentTable)) {
          showResult("Empate");
        } else {
          currentPlayer = player;
        }
      });
    }
  }

  void makeMove(int index) {
    if (currentTable[index] == "") {
      setState(() {
        currentTable[index] = currentPlayer;


        if (winCheck(currentPlayer, currentTable)) {
          showResult("Jogador $currentPlayer ganhou!");
        } else if (isFull(currentTable)) {
          showResult("Empate!");
        } else {

          if (vsIA) {
            currentPlayer = computer;
            iaMove();
          } else {
            currentPlayer = currentPlayer == player ? player2 : player;
          }
        }
      });
    }
  }

  void showResult(String result) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(result),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: const Text("Reiniciar"),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      currentTable = List.filled(9, '');
      currentPlayer = player;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [

          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => makeMove(index),
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        currentTable[index],
                        style: const TextStyle(fontSize: 36),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    vsIA = !vsIA;
                    resetGame();
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(vsIA ? "Modo: Computador" : "Modo: Jogador",
                    style: TextStyle(color: Colors.amber[50], fontSize: 15)),
              ),
              ElevatedButton(
                onPressed: resetGame,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text("Reiniciar",
                    style: TextStyle(color: Colors.amber[50], fontSize: 15)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
