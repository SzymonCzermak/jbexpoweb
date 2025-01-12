import 'package:flutter/material.dart';

class ButtonStyles {
  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    backgroundColor: const Color.fromARGB(
        255, 255, 193, 7), // Zmieniono kolor tła na bardziej żywy
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Zaokrąglone rogi
      side: const BorderSide(
        color: Color.fromARGB(255, 0, 0, 0),
        width: 1.5,
      ),
    ),
    elevation: 10, // Zmniejszono wartość elevation
    shadowColor: const Color.fromARGB(255, 0, 0, 0)
        .withOpacity(0.5), // Zmieniono kolor cienia na bardziej wyrazisty
  );

  static ButtonStyle textButtonStyle = TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    backgroundColor: const Color.fromARGB(
        255, 255, 193, 7), // Zmieniono kolor tła na bardziej żywy
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Zaokrąglone rogi
      side: const BorderSide(
        color: Color.fromARGB(255, 0, 0, 0),
        width: 1.5,
      ),
    ),
    shadowColor: const Color.fromARGB(255, 0, 0, 0)
        .withOpacity(0.5), // Zmieniono kolor cienia na bardziej wyrazisty
  );

  static ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    backgroundColor: const Color.fromARGB(
        255, 255, 193, 7), // Zmieniono kolor tła na bardziej żywy
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Zaokrąglone rogi
      side: const BorderSide(
        color: Color.fromARGB(255, 0, 0, 0),
        width: 1.5,
      ),
    ),
    shadowColor: const Color.fromARGB(255, 0, 0, 0)
        .withOpacity(0.5), // Zmieniono kolor cienia na bardziej wyrazisty
  );
}
