import 'dart:math';

import 'package:flutter/material.dart';
import 'package:party_box/games/spy_game/start_page.dart';
import 'package:party_box/utils/global_variables.dart'; // Ensure this import is correct
import 'package:party_box/utils/language_selector_screen.dart';

import '../../Screens/main_screen.dart';
import '../../assets/lists/animals_list.dart';
import '../../assets/lists/countries_list.dart';
import '../../assets/lists/places_list.dart'; // Import the Choose Language Screen

class Spy extends StatefulWidget {
  bool? languageChosen;
  Spy({super.key, this.languageChosen});

  final String label = 'Spy';

  @override
  State<Spy> createState() => _SpyState();
}

class _SpyState extends State<Spy> {
  String? _selectedLanguage = 'english'; // Default language
  bool _languageChosen = false;
  int _gameDuration = 3; // Default game duration
  int _numPlayers = 4; // Default number of players
  int _numSpies = 1; // Default number of spies
  String _selectedCategory = 'Animals'; // Default category
  String? _chosenWord; // Variable to hold the chosen word
  bool _isLoading = true;
  late final List<int> _spyIndexes = [];

  final List<String> _categories = [
    'Places',
    'Animals',
    'Countries'
  ]; // Categories for the game

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _languageChosen = widget.languageChosen ?? false;
    if (!_languageChosen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _chooseLanguage();
      });
    } else {
      _selectedLanguage = lastSelectedLang;
      _isLoading = false;
    }
  }

  Future<void> _chooseLanguage() async {
    final selectedLanguage = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChooseLanguageScreen()),
    );

    setState(() {
      _selectedLanguage = selectedLanguage ??
          'english'; // Default to English if no language chosen
      lastSelectedLang = _selectedLanguage; // Update global variable
      _languageChosen = true;
      _isLoading = false;
    });
  }

  List<Map<String, String>> _getListByCategory() {
    if (_selectedCategory == 'Animals') {
      return animalsList; // From animals_list.dart
    } else if (_selectedCategory == 'Places') {
      return placesList; // From places_list.dart
    } else {
      return countriesList; // From countries_list.dart
    }
  }

  // Method to start the game
  void _startGame() {
    Random random = Random();
    List<Map<String, String>> categoryList = _getListByCategory();
    if (categoryList.isNotEmpty) {
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
    _spyIndexes.clear();
    while (_spyIndexes.length < _numSpies) {
      int randomSpyIndex = random.nextInt(_numPlayers);
      if (!_spyIndexes.contains(randomSpyIndex)) {
        _spyIndexes.add(randomSpyIndex);
      }
    }
    print('Starting game with:');
    print('Language: $_selectedLanguage');
    print('Time: $_gameDuration minutes');
    print('Players: $_numPlayers');
    print('Spies: $_numSpies');
    print('Category: $_selectedCategory');
    // Add game logic or navigation to the game screen here
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StartPage(
              numPlayers: _numPlayers,
              selectedWord: _chosenWord,
              gameDuration: _gameDuration,
              spyIndexes: _spyIndexes)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        Navigator.popAndPushNamed(context, '/main');
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Spy Game'),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ));
            },
          ),
        ),
        body: _isLoading
            ? const Center(
                child:
                    CircularProgressIndicator()) // Show loading indicator while loading
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Configure Your Spy Game',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      const SizedBox(height: 20),

                      // Language Display
                      Text(
                        'Selected Language: $_selectedLanguage',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 20),

                      // Time Selection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Game Duration (minutes):',
                              style: TextStyle(color: Colors.white)),
                          DropdownButton<int>(
                            value: _gameDuration,
                            dropdownColor: Colors.black,
                            items: [1, 3, 5, 10, 15, 20, 30]
                                .map((value) => DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(value.toString(),
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _gameDuration = value ?? 10;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Number of Players
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Number of Players:',
                              style: TextStyle(color: Colors.white)),
                          DropdownButton<int>(
                            value: _numPlayers,
                            dropdownColor: Colors.black,
                            items: List.generate(10, (index) => index + 2)
                                .map((value) => DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(value.toString(),
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _numPlayers = value ?? 4;
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
                          const Text('Number of Spies:',
                              style: TextStyle(color: Colors.white)),
                          DropdownButton<int>(
                            value: _numSpies,
                            dropdownColor: Colors.black,
                            items: List.generate(
                                    _numPlayers - 1, (index) => index + 1)
                                .map((value) => DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(value.toString(),
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _numSpies = value ?? 1;
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
                          const Text('Category:',
                              style: TextStyle(color: Colors.white)),
                          DropdownButton<String>(
                            value: _selectedCategory,
                            dropdownColor: Colors.black,
                            items: _categories
                                .map((category) => DropdownMenuItem<String>(
                                      value: category,
                                      child: Text(category,
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value ?? 'All';
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 50),
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
      ),
    );
  }
}
