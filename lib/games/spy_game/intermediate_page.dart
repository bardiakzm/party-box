import 'package:flutter/material.dart';

class IntermediatePage extends StatelessWidget {
  final VoidCallback onNext;
  final int playerNumber;
  final int totalPlayers;

  const IntermediatePage({
    Key? key,
    required this.onNext,
    required this.playerNumber,
    required this.totalPlayers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Player $playerNumber, get ready!',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tap Next to see your role.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 220),
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: onNext,
                    child: const Text(
                      'Next',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
