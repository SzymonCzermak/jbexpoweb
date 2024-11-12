import 'package:flutter/material.dart';
import 'jbexpo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JB Expo Plus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Ustawiamy JBExpoPage jako stronę główną
      home: const JBExpoPage(),
    );
  }
}
