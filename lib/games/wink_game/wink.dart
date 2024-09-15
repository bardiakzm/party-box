import 'package:flutter/cupertino.dart';

class Wink extends StatefulWidget {
  final String label = 'Wink';
  const Wink({super.key});

  @override
  State<Wink> createState() => _SpyState();
}

class _SpyState extends State<Wink> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
