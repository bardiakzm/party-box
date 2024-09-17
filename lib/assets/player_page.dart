import 'package:flutter/material.dart';

import 'exit_confirmation_dialog.dart';

class PlayerPage extends StatelessWidget {
  final String text;
  final VoidCallback onNext;
  final int playerNumber;
  final int totalPlayers;
  final String returnRouteName;

  const PlayerPage({
    Key? key,
    required this.text,
    required this.onNext,
    required this.playerNumber,
    required this.totalPlayers,
    required this.returnRouteName,
  }) : super(key: key);

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ExitConfirmationDialog(
            routeName: returnRouteName); // Use the dialog with your route
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        _showExitDialog(context);
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Player $playerNumber of $totalPlayers'),
                const SizedBox(height: 20),
                Text(
                  text,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w400),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 220),
                  child: SizedBox(
                    height: 100,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: onNext,
                      child: Text(
                        playerNumber < totalPlayers ? 'Next Player' : 'Finish',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                    ),
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
