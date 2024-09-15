import 'package:flutter/material.dart';
import 'package:party_box/utils/language_selector_screen.dart'; // Import the Choose Language Screen

class Spy extends StatefulWidget {
  final String label = 'Spy';
  const Spy({super.key});

  @override
  State<Spy> createState() => _SpyState();
}

class _SpyState extends State<Spy> {
  String? _selectedLanguage;
  bool _languageChosen = false; // Flag to ensure language is only chosen once

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_languageChosen) {
      // Delay language selection until after the frame has finished building
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _chooseLanguage();
      });
    }
  }

  // Method to show the ChooseLanguageScreen and store the selected language
  Future<void> _chooseLanguage() async {
    final selectedLanguage = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChooseLanguageScreen()),
    );

    setState(() {
      _selectedLanguage =
          selectedLanguage ?? 'English'; // Default to English if null
      _languageChosen = true; // Mark that language has been chosen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spy Game'),
        backgroundColor: Colors.black,
      ),
      body: _selectedLanguage == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to Spy Game!',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Language: $_selectedLanguage',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _chooseLanguage, // Button to re-select language
                    child: const Text('Change Language'),
                  ),
                ],
              ),
            ),
    );
  }
}
