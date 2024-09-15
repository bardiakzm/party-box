import 'package:flutter/material.dart';

import 'setting_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              itemCount: 10, // Replace with the number of games
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.purple,
                  // child: Center(child: Text('Game $index')),
                  child: FloatingActionButton(onPressed: () {}),
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
                // primary: Colors.pinkAccent,
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
