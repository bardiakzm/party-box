import 'package:flutter/material.dart';
import 'package:party_box/games/Charades_game/Charades.dart';
import 'package:party_box/games/pantomime_game/Pantomime.dart';

import 'Screens/main_screen.dart';
import 'games/spy_game/spy.dart';
import 'games/wink_game/wink.dart';

void main() {
  runApp(const PartyBoxApp());
}

class PartyBoxApp extends StatelessWidget {
  const PartyBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.dark,
      ),
      // home: const SplashScreen(),
      initialRoute: '/main',
      routes: {
        '/main': (context) => const MainScreen(), // Root route
        '/spy': (context) => Spy(), // Route for Spy Game
        '/spyl': (context) => Spy(
              languageChosen: true,
            ), // Route for Spy Game but use globally saved lang
        '/wink': (context) => const Wink(), // Route for Wink Game
        '/winkl': (context) => const Wink(),
        '/pant': (context) => Pantomime(), // Route for Pantomime Game
        '/char': (context) => Charades(), // Route for Charades Game
        '/pantl': (context) => Pantomime(
              languageChosen: true,
            ), // Route for Pantomime Game
        '/charl': (context) => Charades(
              languageChosen: true,
            ) // Route for Charades Game
      },
    );
  }
}
