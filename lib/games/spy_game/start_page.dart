import 'package:flutter/material.dart';
import 'package:party_box/assets/timer_page.dart';

import 'intermediate_page.dart';
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
  bool _showIntermediatePage = false; // New state for intermediate page

  void _startGame() {
    setState(() {
      _gameStarted = true;
      _currentPlayer = 0;
      _showIntermediatePage = true; // Show the intermediate page first
    });
  }

  void _nextPlayer() {
    if (_showIntermediatePage) {
      setState(() {
        _showIntermediatePage =
            false; // After the intermediate page, show the player page
      });
    } else {
      if (_currentPlayer < widget.numPlayers - 1) {
        setState(() {
          _currentPlayer++;
          _showIntermediatePage =
              true; // Show the intermediate page for the next player
        });
      } else {
        // All players have seen their roles, end the game or move to the next phase
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CircularTimer(duration: widget.gameDuration * 60)),
        );
      }
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
    } else if (_showIntermediatePage) {
      // Show the intermediate page before showing the player's role
      return IntermediatePage(
        onNext: _nextPlayer,
        playerNumber: _currentPlayer + 1,
        totalPlayers: widget.numPlayers,
      );
    } else {
      // Show the player's role page
      return PlayerPage(
        text: _getCurrentPlayerRole(),
        onNext: _nextPlayer,
        playerNumber: _currentPlayer + 1,
        totalPlayers: widget.numPlayers,
      );
    }
  }
}
