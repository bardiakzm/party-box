import 'package:flutter/material.dart';

class PlayerPage extends StatelessWidget {
  late String text; // spy or the chosen word
  PlayerPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 140,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 300,
            ),
            SizedBox(
              width: 150, // Adjust width here
              height: 60, // Adjust height here
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 18), // Adjust text size if needed
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
