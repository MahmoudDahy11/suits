import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const Suits());
}

class Suits extends StatelessWidget {
  const Suits({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false);
  }
}
