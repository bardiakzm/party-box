import 'package:flutter/material.dart';
import 'package:party_box/games/game.dart';

class ChooseLanguageScreen extends StatelessWidget {
  final Game? parentWidget;
  const ChooseLanguageScreen({super.key, required this.parentWidget});

  void _onLanguageSelected(
      BuildContext context, String language, Game targetPage) {
    // Navigator.pop(context, language); // Return the selected language
    Navigator.pushReplacementNamed(context, '/${targetPage.navigationLabel}l',
        result: language);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => targetPage));
    Navigator.pop;
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
                  onPressed: () =>
                      _onLanguageSelected(context, 'english', parentWidget!),
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
                  onPressed: () =>
                      _onLanguageSelected(context, 'persian', parentWidget!),
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
