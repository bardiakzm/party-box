import 'package:flutter/material.dart';

class ExitConfirmationDialog extends StatelessWidget {
  final String routeName; // This will accept the named route

  const ExitConfirmationDialog({Key? key, required this.routeName})
      : super(key: key);

  void _navigateToRoute(BuildContext context) {
    Navigator.of(context).pop(); // Close the dialog
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Exit'),
      content: const Text('Are you sure you want to exit?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            _navigateToRoute(context);
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
