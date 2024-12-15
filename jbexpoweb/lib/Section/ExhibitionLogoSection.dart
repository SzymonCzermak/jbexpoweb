import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

class ExhibitionLogosSection extends StatefulWidget {
  final bool isPolish;

  const ExhibitionLogosSection({Key? key, required this.isPolish})
      : super(key: key);

  @override
  _ExhibitionLogosSectionState createState() => _ExhibitionLogosSectionState();
}

class _ExhibitionLogosSectionState extends State<ExhibitionLogosSection> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.offset;

        if (currentScroll >= maxScroll) {
          _scrollController.jumpTo(0); // Wraca do początku
        } else {
          _scrollController.animateTo(
            currentScroll + 10, // Przesuwa o 10 jednostek
            duration: const Duration(milliseconds: 100),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Pobieramy wymiary ekranu
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamiczne wartości
    final fontSize = screenWidth > 600
        ? 60.0
        : screenWidth * 0.07; // Zmniejsz rozmiar tekstu na małych ekranach
    final imageSize = screenWidth > 600
        ? 500.0
        : screenWidth * 0.6; // Zmniejsz rozmiar logotypów na małych ekranach
    final horizontalPadding = screenWidth > 600
        ? 32.0
        : 16.0; // Zmniejsz marginesy na małych ekranach

    return Container(
      width: double.infinity, // Pełna szerokość
      height: screenHeight * 0.8, // Wysokość sekcji dostosowana do ekranu
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: screenHeight * 0.05, // Dynamiczna wysokość odstępu
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: horizontalPadding, // Responsywny margines
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.openSans(
                  fontSize: fontSize, // Responsywny rozmiar tekstu
                  color: const Color.fromARGB(
                      255, 216, 216, 216), // Domyślny kolor tekstu
                  fontWeight: FontWeight.bold, // Styl czcionki
                ),
                children: [
                  TextSpan(
                    text: widget.isPolish
                        ? "Braliśmy udział w "
                        : "We participated in ",
                  ),
                  TextSpan(
                    text: widget.isPolish
                        ? "czołowych targach europejskich"
                        : "leading European trade fairs",
                    style: GoogleFonts.openSans(
                      color:
                          const Color.fromARGB(255, 161, 151, 0), // Złoty kolor
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: widget.isPolish
                        ? ", gdzie nasze stoiska "
                        : ", where our booths ",
                  ),
                  TextSpan(
                    text: widget.isPolish
                        ? "zachwycały jakością i nowoczesnym designem."
                        : "impressed with quality and modern design.",
                    style: GoogleFonts.openSans(
                      color:
                          const Color.fromARGB(255, 161, 151, 0), // Złoty kolor
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics:
                  const NeverScrollableScrollPhysics(), // Wyłączamy ręczne przewijanie
              itemCount: 42,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Image.asset(
                    'assets/LogaTargow/${(index % 42) + 1}.png', // Zapętlenie logotypów
                    width: imageSize, // Responsywna szerokość obrazka
                    height: imageSize, // Responsywna wysokość obrazka
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
