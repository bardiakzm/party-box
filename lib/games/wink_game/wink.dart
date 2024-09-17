import 'dart:math';

import 'package:flutter/material.dart';

import 'start_page.dart';

class Wink extends StatefulWidget {
  const Wink({super.key});
  final String label = 'Wink';
  @override
  _WinkState createState() => _WinkState();
}

class _WinkState extends State<Wink> {
  int _numPlayers = 5; // Default number of players
  int _numKillers = 1; // Default number of killers
  int _gameDuration = 5; // Default game duration
  late final List<int> _killerIndexes = [];

  // Method to start the game
  void _startGame() {
    Random random = Random();
    _killerIndexes.clear();
    while (_killerIndexes.length < _numKillers) {
      int randomKillerIndex = random.nextInt(_numPlayers);
      if (!_killerIndexes.contains(randomKillerIndex)) {
        _killerIndexes.add(randomKillerIndex);
      }
    }

    print('Starting Wink Game with:');
    print('Players: $_numPlayers');
    print('Killers: $_numKillers');
    print('Game Duration: $_gameDuration minutes');
    print('Killer indexes: $_killerIndexes');
    // Navigate to the next game screen or logic here

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StartPage(
              numPlayers: _numPlayers,
              gameDuration: _gameDuration,
              killerIndexes: _killerIndexes)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wink Game'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Configure Your Wink Game',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),

              // Number of Players
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Number of Players:'),
                  DropdownButton<int>(
                    value: _numPlayers,
                    items: List.generate(29, (index) => index + 2)
                        .map((value) => DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _numPlayers = value ?? 5;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Number of Killers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Number of Killers:'),
                  DropdownButton<int>(
                    value: _numKillers,
                    items: List.generate(_numPlayers - 1, (index) => index + 1)
                        .map((value) => DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _numKillers = value ?? 1;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Game Duration
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Game Duration (minutes):'),
                  DropdownButton<int>(
                    value: _gameDuration,
                    items: [1, 3, 5, 10, 15, 20, 30]
                        .map((value) => DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _gameDuration = value ?? 5;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Start Button
              ElevatedButton(
                onPressed: _startGame,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  backgroundColor: Colors.pinkAccent,
                ),
                child: const Text(
                  'Start Game',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
