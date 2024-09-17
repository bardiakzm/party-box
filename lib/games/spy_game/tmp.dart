import 'dart:math';

import 'package:flutter/material.dart';
import 'package:party_box/assets/animals_list.dart'; // import your assets
import 'package:party_box/assets/countries_list.dart';
import 'package:party_box/assets/places_list.dart';

class Spy extends StatefulWidget {
  final String label = 'Spy';
  const Spy({super.key});

  @override
  State<Spy> createState() => _SpyState();
}

class _SpyState extends State<Spy> {
  int _numPlayers = 4; // Default number of players
  int _numSpies = 1; // Default number of spies
  int _gameDuration = 10; // Default game duration in minutes
  String _selectedCategory = 'Animals'; // Default category
  String _selectedLanguage = 'fa'; // Default language
  String? _chosenWord; // Variable to hold the chosen word

  final List<String> _categoryItems = ['Animals', 'Places', 'Countries'];
  final List<String> _languageItems = ['fa', 'en']; // Persian and English for now

  // Function to retrieve the list based on the category selected
  List<Map<String, String>> _getListByCategory() {
    if (_selectedCategory == 'Animals') {
      return animalsList; // From animals_list.dart
    } else if (_selectedCategory == 'Places') {
      return placesList; // From places_list.dart
    } else {
      return countriesList; // From countries_list.dart
    }
  }

  void _startGame() {
    // Retrieve the category list based on the selected category
    List<Map<String, String>> categoryList = _getListByCategory();

    // Select a random word from the list based on the selected language
    if (categoryList.isNotEmpty) {
      Random random = Random();
      int randomIndex = random.nextInt(categoryList.length);

      // Check if the selected language exists in the map
      if (categoryList[randomIndex].containsKey(_selectedLanguage)) {
        _chosenWord = categoryList[randomIndex][_selectedLanguage];
        print('Chosen word: $_chosenWord');
      } else {
        print('Language not found in the list.');
        _chosenWord = null; // Handle case where language key doesn't exist
      }
    }

    // Start the game logic after the word has been selected
    print(
        'Starting game with $_numPlayers players, $_numSpies spies, category: $_selectedCategory, language: $_selectedLanguage');

    // Here you can navigate to another screen or implement game logic
    setState(() {}); // Update UI to show chosen word
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spy Game'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Number of Players
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Number of Players', style: TextStyle(fontSize: 18)),
                DropdownButton<int>(
                  value: _numPlayers,
                  items: List.generate(10, (index) => index + 3)
                      .map<DropdownMenuItem<int>>(
                        (int value) => DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _numPlayers = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Number of Spies
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Number of Spies', style: TextStyle(fontSize: 18)),
                DropdownButton<int>(
                  value: _numSpies,
                  items: List.generate(_numPlayers - 1, (index) => index + 1)
                      .map<DropdownMenuItem<int>>(
                        (int value) => DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _numSpies = value!;
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
                const Text('Game Duration (minutes)',
                    style: TextStyle(fontSize: 18)),
                DropdownButton<int>(
                  value: _gameDuration,
                  items: List.generate(30, (index) => index + 5)
                      .map<DropdownMenuItem<int>>(
                        (int value) => DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _gameDuration = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Category Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Category', style: TextStyle(fontSize: 18)),
                DropdownButton<String>(
                  value: _selectedCategory,
                  items: _categoryItems
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Language Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Language', style: TextStyle(fontSize: 18)),
                DropdownButton<String>(
                  value: _selectedLanguage,
                  items: _languageItems
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value == 'fa' ? 'Persian' : 'English'),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Start Button
            ElevatedButton(
              onPressed: _startGame,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Start Game'),
            ),

            // Display the chosen word
            if (_chosenWord != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Chosen Word: $_chosenWord',
                  style: const TextStyle(fontSize: 22, color: Colors.blueAccent),
                ),
              ),
            if (_chosenWord == null)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'No word chosen. Please check your language/category selection.',
                  style: TextStyle(fontSize: 18, color: Colors.redAccent),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
