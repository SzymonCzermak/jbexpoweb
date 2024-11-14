import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThirdSection extends StatefulWidget {
  final bool isPolish;

  const ThirdSection({Key? key, required this.isPolish}) : super(key: key);

  @override
  _ThirdSectionState createState() => _ThirdSectionState();
}

class _ThirdSectionState extends State<ThirdSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Animacja przesunięcia tekstu z lewej strony
    _slideAnimation = Tween<Offset>(
      begin: Offset(-1.5, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Rozpoczęcie animacji przy załadowaniu widgetu
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Przesunięcie tekstu Satysfakcja klientów
            SlideTransition(
              position: _slideAnimation,
              child: Text(
                widget.isPolish
                    ? "Pełna satysfakcja klientów"
                    : "Customer Satisfaction",
                style: GoogleFonts.openSans(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 5.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Przesunięcie tekstu opisu
            SlideTransition(
              position: _slideAnimation,
              child: Text(
                widget.isPolish
                    ? "Gwarantujemy pełną satysfakcję z naszych usług!"
                    : "We guarantee full satisfaction with our services!",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 40),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: LinearProgressIndicator(
                        value: _animation.value / 100,
                        minHeight: 20,
                        backgroundColor: Colors.grey.shade300,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "${_animation.value.toInt()}%",
                      style: GoogleFonts.openSans(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 5.0,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
