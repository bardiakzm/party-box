import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  Game({super.key});
  String label = 'Spy';
  String navigationLabel = 'spy';
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
