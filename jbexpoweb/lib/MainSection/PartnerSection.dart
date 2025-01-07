import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

class PartnerSection extends StatefulWidget {
  final bool isPolish;

  const PartnerSection({Key? key, required this.isPolish}) : super(key: key);

  @override
  _PartnerSectionState createState() => _PartnerSectionState();
}

class _PartnerSectionState extends State<PartnerSection> {
  final ScrollController _scrollControllerTop = ScrollController();
  late Timer _topTimer;
  int _scrollSpeed = 100; // Prędkość przewijania w milisekundach
  bool _isScrolling = true; // Flaga dla stanu przewijania

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _topTimer.cancel();
    _scrollControllerTop.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _topTimer = Timer.periodic(Duration(milliseconds: _scrollSpeed), (timer) {
      if (_scrollControllerTop.hasClients) {
        double maxScroll = _scrollControllerTop.position.maxScrollExtent;
        double currentScroll = _scrollControllerTop.offset;

        if (currentScroll >= maxScroll) {
          _scrollControllerTop.jumpTo(0); // Wraca do początku
        } else {
          _scrollControllerTop.animateTo(
            currentScroll + 10, // Przesuwa o 10 jednostek
            duration: Duration(milliseconds: _scrollSpeed),
            curve: Curves.linear,
          );
        }
      }
    });
    setState(() {
      _isScrolling = true; // Przewijanie aktywne
    });
  }

  void _stopAutoScroll() {
    if (_topTimer.isActive) {
      _topTimer.cancel(); // Zatrzymaj timer
      setState(() {
        _isScrolling = false; // Przewijanie zatrzymane
      });
    }
  }

  void _updateScrollSpeed(int newSpeed) {
    setState(() {
      _scrollSpeed = newSpeed; // Zaktualizuj prędkość
      if (_isScrolling) {
        _stopAutoScroll();
        _startAutoScroll(); // Uruchom ponownie z nową prędkością
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? screenWidth * 0.1 : 16.0;
    final bool isSmallScreen = screenWidth < 600;

    final double titleFontSize = isSmallScreen ? 30.0 : 80.0;
    final double subtitleFontSize = isSmallScreen ? 14.0 : 18.0;

    // Dynamiczne wymiary logotypów
    final double logoWidth = isSmallScreen ? screenWidth * 0.7 : 500.0;
    final double logoHeight = isSmallScreen ? screenWidth * 0.35 : 250.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.michroma(
                      fontSize: titleFontSize,
                      color: const Color.fromARGB(255, 216, 216, 216),
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: widget.isPolish
                            ? "Nasza obecność na "
                            : "Our presence at ",
                      ),
                      TextSpan(
                        text: widget.isPolish
                            ? "europejskich targach"
                            : "European trade fairs",
                        style: GoogleFonts.michroma(
                          color: const Color.fromARGB(255, 161, 151, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.michroma(
                      fontSize: subtitleFontSize,
                      color: const Color.fromARGB(255, 216, 216, 216),
                    ),
                    children: [
                      TextSpan(
                        text: widget.isPolish
                            ? "gdzie nasze stoiska zachwycały jakością i nowoczesnym designem."
                            : "where our booths impressed with quality and modern design.",
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Divider(
                    color: Color.fromARGB(255, 255, 255, 255), // Kolor kreski
                    thickness: 2, // Grubość kreski
                    indent: 50, // Wcięcie od lewej
                    endIndent: 50, // Wcięcie od prawej
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            children: [
              Container(
                height: logoHeight,
                child: ListView.builder(
                  controller: _scrollControllerTop,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 42,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        width: logoWidth,
                        height: logoHeight,
                        child: Image.asset(
                          'assets/LogaTargow/${(index % 42) + 1}.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 8, // Grubość kreski
                  color: const Color.fromARGB(255, 161, 151, 0),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 8, // Grubość kreski
                  color: const Color.fromARGB(255, 161, 151, 0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Spowolnij
              _buildActionButton(
                label: widget.isPolish ? "Spowolnij" : "Slow Down",
                onPressed: () => _updateScrollSpeed(200),
              ),
              const SizedBox(width: 10), // Odstęp między przyciskami
              // Stop/Start
              _buildActionButton(
                label: _isScrolling
                    ? (widget.isPolish ? "Stop" : "Stop")
                    : (widget.isPolish ? "Start" : "Start"),
                onPressed: () =>
                    _isScrolling ? _stopAutoScroll() : _startAutoScroll(),
              ),
              const SizedBox(width: 10), // Odstęp między przyciskami
              // Przyspiesz
              _buildActionButton(
                label: widget.isPolish ? "Przyspiesz" : "Speed Up",
                onPressed: () => _updateScrollSpeed(50),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // Ustal responsywny rozmiar przycisków
    final double buttonWidth = screenWidth < 400
        ? screenWidth * 0.3 // Na bardzo małych ekranach (np. telefonach)
        : screenWidth < 800
            ? screenWidth * 0.2 // Średnie ekrany (np. tablety)
            : 200; // Duże ekrany (np. komputery)

    final double fontSize = screenWidth < 400 ? 10 : 12; // Rozmiar czcionki

    return SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          backgroundColor: const Color.fromARGB(96, 94, 94, 94),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Color.fromARGB(255, 194, 181, 0),
              width: 1.0,
            ),
          ),
          elevation: 10,
          shadowColor: const Color.fromARGB(255, 121, 113, 0).withOpacity(0.4),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: GoogleFonts.michroma(
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
