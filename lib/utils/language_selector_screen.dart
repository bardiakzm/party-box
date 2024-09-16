import 'package:flutter/material.dart';

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({super.key});

  void _onLanguageSelected(BuildContext context, String language) {
    Navigator.pop(context, language); // Return the selected language
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        Navigator.pushNamedAndRemoveUntil(
            context, '/main', ModalRoute.withName('/'));
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/main', ModalRoute.withName('/'));
              },
            ),
            title: const Text('Choose Language'),
            backgroundColor: Colors.black,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Select your language',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => _onLanguageSelected(context, 'english'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 50),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('English'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _onLanguageSelected(context, 'persian'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 50),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Persian'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
