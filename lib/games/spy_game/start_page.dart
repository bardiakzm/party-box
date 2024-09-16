import 'package:flutter/material.dart';
import 'package:party_box/assets/timer_page.dart';

import 'player_page.dart';

class StartPage extends StatefulWidget {
  final int numPlayers;
  final int gameDuration;
  final String? selectedWord;
  final List<int> spyIndexes;

  const StartPage({
    Key? key,
    required this.numPlayers,
    required this.gameDuration,
    required this.selectedWord,
    required this.spyIndexes,
  }) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int _currentPlayer = -1;
  bool _gameStarted = false;

  void _startGame() {
    setState(() {
      _gameStarted = true;
      _currentPlayer = 0;
    });
  }

  void _nextPlayer() {
    if (_currentPlayer < widget.numPlayers - 1) {
      setState(() {
        _currentPlayer++;
      });
    } else {
      // All players have seen their roles, end the game or move to the next phase
      // Navigator.of(context).pop(); // Or navigate to a game screen
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CircularTimer(duration: widget.gameDuration * 60)),
      );
    }
  }

  String _getCurrentPlayerRole() {
    return widget.spyIndexes.contains(_currentPlayer)
        ? 'Spy'
        : widget.selectedWord ?? 'Regular Player';
  }

  @override
  Widget build(BuildContext context) {
    if (!_gameStarted) {
      return SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Tap next to start the game',
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 150,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _startGame,
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return PlayerPage(
        text: _getCurrentPlayerRole(),
        onNext: _nextPlayer,
        playerNumber: _currentPlayer + 1,
        totalPlayers: widget.numPlayers,
      );
    }
  }
}
