import 'package:flutter/material.dart';

class PlayerPage extends StatelessWidget {
  final String text;
  final VoidCallback onNext;
  final int playerNumber;
  final int totalPlayers;

  const PlayerPage({
    Key? key,
    required this.text,
    required this.onNext,
    required this.playerNumber,
    required this.totalPlayers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Player $playerNumber of $totalPlayers'),
            const SizedBox(height: 20),
            Text(
              text,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: onNext,
              child:
                  Text(playerNumber < totalPlayers ? 'Next Player' : 'Finish'),
            ),
          ],
        ),
      ),
    );
  }
}

// class PlayerPage extends StatelessWidget {
//   late String text; // spy or the chosen word
//   PlayerPage({super.key, required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(
//               height: 140,
//             ),
//             Text(
//               text,
//               style: TextStyle(fontSize: 25),
//             ),
//             const SizedBox(
//               height: 300,
//             ),
//             SizedBox(
//               width: 150, // Adjust width here
//               height: 60, // Adjust height here
//               child: FloatingActionButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text(
//                   'Next',
//                   style: TextStyle(fontSize: 18), // Adjust text size if needed
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }
