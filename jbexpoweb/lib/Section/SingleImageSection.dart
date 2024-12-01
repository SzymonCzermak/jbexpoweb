import 'package:flutter/material.dart';

class SingleImageSection extends StatefulWidget {
  final bool isPolish;

  const SingleImageSection({super.key, required this.isPolish});

  @override
  _SingleImageSectionState createState() => _SingleImageSectionState();
}

class _SingleImageSectionState extends State<SingleImageSection> {
  bool isHovered = false;

  void _onHover(bool hovering) {
    setState(() {
      isHovered = hovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    // Ustawienia rozmiaru obrazu w zależności od wielkości ekranu
    final double imageSize = isMobile
        ? screenWidth * 0.8 // Na małych ekranach 80% szerokości
        : screenWidth * 0.4; // Na dużych ekranach 40% szerokości ekranu

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0), // Marginesy
      child: isMobile
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Obrazek na górze
                _buildImage(imageSize),
                const SizedBox(height: 20), // Odstęp między obrazem a tekstem
                // Tekst pod obrazkiem
                _buildText(),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Obrazek po lewej
                Expanded(
                  flex: 3,
                  child: _buildImage(imageSize),
                ),
                const SizedBox(width: 20), // Odstęp między obrazem a tekstem
                // Tekst po prawej
                Expanded(
                  flex: 3,
                  child: _buildText(),
                ),
              ],
            ),
    );
  }

  Widget _buildImage(double imageSize) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: () => print("Image clicked"),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isHovered ? 30 : 20),
              bottomRight: Radius.circular(isHovered ? 30 : 20),
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: const Color.fromARGB(255, 7, 23, 255)
                          .withOpacity(0.8),
                      blurRadius: 50,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Obrazek
              Transform.scale(
                scale: isHovered ? 1.05 : 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isHovered ? 30 : 20),
                    bottomRight: Radius.circular(isHovered ? 30 : 20),
                  ),
                  child: Image.asset(
                    'assets/Targi/1.png',
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Nakładka koloru
              AnimatedOpacity(
                opacity: isHovered ? 0.3 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isHovered ? 30 : 20),
                    bottomRight: Radius.circular(isHovered ? 30 : 20),
                  ),
                  child: Container(
                    color: const Color.fromARGB(99, 7, 73, 255),
                    width: imageSize,
                    height: imageSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        widget.isPolish
            ? 'W Madrycie na targach GENERA 2023 zaprezentowaliśmy nasze stoisko z nowoczesnymi modułami solarnymi Tongwei.'
            : 'At GENERA 2023 in Madrid, we showcased our booth featuring cutting-edge solar modules by Tongwei.',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20, // Dopasowanie rozmiaru tekstu do obrazu
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
