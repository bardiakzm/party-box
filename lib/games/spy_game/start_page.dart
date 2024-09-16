import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  int numPlayers = 4;
  int numSpies = 1;
  int gameDuration = 10;
  String? selectedWord;
  StartPage(
      {super.key,
      required this.numPlayers,
      required this.numSpies,
      required this.gameDuration,
      required this.selectedWord});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 140,
            ),
            const Text(
              'Tap next to start the game',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 300,
            ),
            SizedBox(
              width: 150, // Adjust width here
              height: 60, // Adjust height here
              child: FloatingActionButton(
                onPressed: () {
                  // Add your action here
                },
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 18), // Adjust text size if needed
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
