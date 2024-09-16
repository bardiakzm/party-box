import 'package:flutter/material.dart';

import 'Screens/main_screen.dart';
import 'games/spy_game/spy.dart';

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
      },
    );
  }
}
