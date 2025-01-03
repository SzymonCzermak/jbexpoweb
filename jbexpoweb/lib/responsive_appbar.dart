import 'package:flutter/material.dart';

class StaticAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(int) onNavigate; // Funkcja do obsługi nawigacji
  final int currentIndex; // Aktualnie wybrana strona

  const StaticAppBar({
    Key? key,
    required this.onNavigate,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'JB Expo Plus',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      centerTitle: true,
      actions: [
        _buildNavButton(context, 0, "Home"),
        _buildNavButton(context, 1, "How We Work"),
        _buildNavButton(context, 2, "Portfolio"),
      ],
    );
  }

  Widget _buildNavButton(BuildContext context, int index, String label) {
    return TextButton(
      onPressed: () {
        if (currentIndex != index) {
          onNavigate(index); // Przełącz na nową stronę
        }
      },
      child: Text(
        label,
        style: TextStyle(
          color: currentIndex == index ? Colors.yellow : Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
