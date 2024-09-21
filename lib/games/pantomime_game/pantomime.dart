import 'dart:math';

import 'package:flutter/material.dart';
import 'package:party_box/games/game.dart';
import 'package:party_box/utils/global_variables.dart';
import 'package:party_box/utils/language_selector_screen.dart';

import '../../Screens/main_screen.dart';
import '../../assets/lists/animals_list.dart';
import '../../assets/lists/countries_list.dart';
import '../../assets/lists/foods_list.dart';
import '../../assets/lists/movies_list.dart';
import '../../assets/lists/objects_list.dart';
import '../../assets/lists/places_list.dart';

class Pantomime extends Game {
  bool? languageChosen;
  Pantomime({super.key, this.languageChosen}) {
    super.label = 'Pantomime';
    super.navigationLabel = 'pant';
  }

  @override
  State<Pantomime> createState() => _PantomimeState();
}

class _PantomimeState extends State<Pantomime> {
  String? _selectedLanguage = 'english'; // Default language
  bool _languageChosen = false;
  int _gameDuration = 3; // Default game duration
  int _numPlayers = 4; // Default number of players
  String _selectedCategory = 'Animals'; // Default category
  String? _chosenWord; // Variable to hold the chosen word
  bool _isLoading = true;

  final List<String> _categories = [
    'Animals',
    'Foods',
    'Countries',
    'Places',
    'Objects',
    'Movies'
  ]; // Categories for the Pantomime game

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _languageChosen = widget.languageChosen ?? false;
    if (!_languageChosen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _chooseLanguage(widget);
      });
    } else {
      _selectedLanguage = lastSelectedLang;
      _isLoading = false;
    }
  }

  Future<void> _chooseLanguage(Game targetPage) async {
    final selectedLanguage = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChooseLanguageScreen(
                parentWidget: targetPage,
              )),
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
    switch (_selectedCategory) {
      case 'Animals':
        return animalsList;
      case 'Foods':
        return foodsList;
      case 'Countries':
        return countriesList;
      case 'Places':
        return placesList;
      case 'Objects':
        return objectsList;
      case 'Movies':
        return moviesAndSeriesList;
      default:
        return [];
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

    print('Starting game with:');
    print('Language: $_selectedLanguage');
    print('Time: $_gameDuration minutes');
    print('Players: $_numPlayers');
    print('Category: $_selectedCategory');
    // Add game logic or navigation to the game screen here
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
          title: const Text('Pantomime Game'),
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
                        'Configure Your Pantomime Game',
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
                                _selectedCategory = value ?? 'Animals';
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
