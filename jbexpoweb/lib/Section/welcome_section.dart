import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeSection extends StatefulWidget {
  final bool isPolish;

  const WelcomeSection({super.key, required this.isPolish});

  @override
  _WelcomeSectionState createState() => _WelcomeSectionState();
}

class _WelcomeSectionState extends State<WelcomeSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _imageOpacityAnimation;
  late Animation<double> _leftTextOpacityAnimation;
  late Animation<double> _rightTextOpacityAnimation;

  bool _isLeftHovered = false;
  bool _isRightHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _imageOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _leftTextOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 0.75, curve: Curves.easeInOut),
      ),
    );

    _rightTextOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.75, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: isMobile
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _imageOpacityAnimation,
                    child: _buildImage(screenWidth),
                  ),
                  const SizedBox(height: 20),
                  FadeTransition(
                    opacity: _leftTextOpacityAnimation,
                    child: _buildHoverableText(isLeft: true, isCentered: true),
                  ),
                  const SizedBox(height: 20),
                  FadeTransition(
                    opacity: _rightTextOpacityAnimation,
                    child: _buildHoverableText(isLeft: false, isCentered: true),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: FadeTransition(
                      opacity: _leftTextOpacityAnimation,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 35.0),
                          child: _buildHoverableText(isLeft: true),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FadeTransition(
                    opacity: _imageOpacityAnimation,
                    child: _buildImage(screenWidth),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: FadeTransition(
                      opacity: _rightTextOpacityAnimation,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: _buildHoverableText(isLeft: false),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildHoverableText({required bool isLeft, bool isCentered = false}) {
    final String text = widget.isPolish
        ? (isLeft
            ? "Nasza kreatywność. Twoja rozpoznawalność na światowej scenie."
            : "Tworzymy miejsca, które budują przyszłość Twojej marki.")
        : (isLeft
            ? "Our creativity. Your recognition on the global stage."
            : "We create spaces that shape your brand's future.");

    final double screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth > 1200
        ? 55 // Duży ekran
        : screenWidth > 800
            ? 28 // Średni ekran
            : 18; // Mały ekran

    return GestureDetector(
      onTap: () => setState(() {
        if (isLeft) {
          _isLeftHovered = true;
        } else {
          _isRightHovered = true;
        }
        Future.delayed(const Duration(milliseconds: 300), () {
          setState(() {
            if (isLeft) {
              _isLeftHovered = false;
            } else {
              _isRightHovered = false;
            }
          });
        });
      }),
      onLongPress: () => setState(() {
        if (isLeft) {
          _isLeftHovered = true;
        } else {
          _isRightHovered = true;
        }
      }),
      onLongPressUp: () => setState(() {
        if (isLeft) {
          _isLeftHovered = false;
        } else {
          _isRightHovered = false;
        }
      }),
      child: MouseRegion(
        onEnter: (_) => setState(() {
          if (isLeft) {
            _isLeftHovered = true;
          } else {
            _isRightHovered = true;
          }
        }),
        onExit: (_) => setState(() {
          if (isLeft) {
            _isLeftHovered = false;
          } else {
            _isRightHovered = false;
          }
        }),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Tło pod tekstem
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isLeft
                  ? (screenWidth > 1200
                      ? 400 // Szerokość dla dużego ekranu
                      : screenWidth > 800
                          ? 300 // Szerokość dla średniego ekranu
                          : 250) // Szerokość dla małego ekranu
                  : (screenWidth > 1200
                      ? 400
                      : screenWidth > 800
                          ? 300
                          : 250), // Tak samo po prawej stronie
              height: screenWidth > 1200
                  ? 280 // Wysokość dla dużego ekranu
                  : screenWidth > 800
                      ? 40 // Wysokość dla średniego ekranu
                      : 30, // Wysokość dla małego ekranu
              decoration: BoxDecoration(
                gradient: (isLeft && _isLeftHovered) ||
                        (!isLeft && _isRightHovered)
                    ? LinearGradient(
                        colors: isLeft
                            ? [
                                const Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.0), // Początek przezroczysty
                                Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.3), // Środek ciemny
                                const Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.0), // Koniec przezroczysty
                              ]
                            : [
                                const Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.0), // Początek przezroczysty
                                Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.3), // Środek ciemny
                                const Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.0), // Koniec przezroczysty
                              ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                    : null, // Brak gradientu, gdy kursor jest poza tekstem
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            // Tekst z animowaną zmianą koloru
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: GoogleFonts.openSans(
                fontSize: fontSize, // Dynamiczny rozmiar czcionki
                fontWeight: FontWeight.w600,
                color: (isLeft && _isLeftHovered)
                    ? Colors.blue
                    : (!isLeft && _isRightHovered)
                        ? Colors.red
                        : Colors.white,
                shadows: [
                  Shadow(
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
              child: Text(
                text,
                textAlign: isLeft ? TextAlign.right : TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(double screenWidth) {
    final double imageWidth = screenWidth > 1200 ? 500 : screenWidth * 0.6;
    final double imageHeight = imageWidth * 1.6;

    return Container(
      width: imageWidth,
      height: imageHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/Welcome.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
