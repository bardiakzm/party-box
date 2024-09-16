import 'package:flutter/material.dart';
import 'package:party_box/games/spy_game/spy.dart';
import 'package:party_box/games/wink_game/wink.dart';
import 'package:party_box/resources/lists.dart';

import 'setting_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // This method returns the appropriate screen based on the index
  Widget _getGameScreen(int index) {
    switch (index) {
      case 0:
        return Spy(languageChosen: false); // Navigates to Spy game
      case 1:
        return Wink(); // Navigates to Wink game
      default:
        return Spy(
            languageChosen:
                false); // Default to Spy game if index is out of bounds
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Party Box'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Game Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: const EdgeInsets.all(10),
              itemCount: gamesList.length, // Number of games
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.purple,
                  child: InkWell(
                    onTap: () {
                      // Navigate to the selected game screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => _getGameScreen(index),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        gamesList[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Surprise Me Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement surprise me functionality
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Surprise Me!'),
            ),
          ),
        ],
      ),
    );
  }
}
