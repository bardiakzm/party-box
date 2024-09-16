import 'package:flutter/material.dart';
import 'package:party_box/Screens/splash_screen.dart';

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
      home: const SplashScreen(),
      routes: {
        '/main': (context) => const MainScreen(), // Root route
        '/spy': (context) => Spy(), // Route for Spy Game
      },
    );
  }
}
