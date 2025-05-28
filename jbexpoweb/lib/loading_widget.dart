import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedLoadingWidget extends StatefulWidget {
  const AnimatedLoadingWidget({super.key});

  @override
  State<AnimatedLoadingWidget> createState() => _AnimatedLoadingWidgetState();
}

class _AnimatedLoadingWidgetState extends State<AnimatedLoadingWidget> {
  final List<String> _loadingMessages = [
    'Rozstawiamy konstrukcję aluminiową...',
    'Wkręcamy ostatnie śruby...',
    'Nakładamy grafikę na ścianki...',
    'Podłączamy światła ekspozycyjne...',
    'Wypolerujemy powierzchnie na błysk...',
    'Układamy materiały promocyjne...',
    'Zaraz odsłonimy Twoją markę...',
  ];

  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _loadingMessages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              _loadingMessages[_currentIndex],
              key: ValueKey<String>(_loadingMessages[_currentIndex]),
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
