import 'package:flutter/cupertino.dart';

class Spy extends StatefulWidget {
  final String label = 'Spy';
  const Spy({super.key});

  @override
  State<Spy> createState() => _SpyState();
}

class _SpyState extends State<Spy> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
