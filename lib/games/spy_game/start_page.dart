import 'package:flutter/material.dart';

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
      Navigator.of(context).pop(); // Or navigate to a game screen
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

// Update your PlayerPage to include onNext callback and player information
class PlayerPage extends StatelessWidget {
  final String text;
  final VoidCallback onNext;
  final int playerNumber;
  final int totalPlayers;

  const PlayerPage({
    Key? key,
    required this.text,
    required this.onNext,
    required this.playerNumber,
    required this.totalPlayers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Player $playerNumber of $totalPlayers'),
            const SizedBox(height: 20),
            Text(
              text,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: onNext,
              child:
                  Text(playerNumber < totalPlayers ? 'Next Player' : 'Finish'),
            ),
          ],
        ),
      ),
    );
  }
}
