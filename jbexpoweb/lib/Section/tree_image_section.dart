import 'package:flutter/material.dart';

class ThreeImageSection extends StatelessWidget {
  const ThreeImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildImageCard('assets/Targi/1.png',
            'JB Expo Plus zaprezentowało swoje stoisko na targach GENERA 2023 w Madrycie, jednym z kluczowych wydarzeń branży energii odnawialnej. Stoisko z nowoczesnymi modułami solarnymi Tongwei przyciągało uwagę odwiedzających dzięki nowoczesnemu designowi i innowacyjnym rozwiązaniom w zakresie energii słonecznej.'),
        _buildImageCard('assets/Targi/2.png', 'Opis 2'),
        _buildImageCard('assets/Targi/3.png', 'Opis 3'),
      ],
    );
  }

  // Funkcja budująca pojedynczą kartę ze zdjęciem
  Widget _buildImageCard(String imagePath, String description) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 45.0), // Większa przestrzeń między obrazami
        child: HoverImageCard(
          imagePath: imagePath,
          description: description,
        ),
      ),
    );
  }
}

class HoverImageCard extends StatefulWidget {
  final String imagePath;
  final String description;

  const HoverImageCard({
    Key? key,
    required this.imagePath,
    required this.description,
  }) : super(key: key);

  @override
  _HoverImageCardState createState() => _HoverImageCardState();
}

class _HoverImageCardState extends State<HoverImageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
      if (isHovered) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: MouseRegion(
        onEnter: (_) => _onEnter(true),
        onExit: (_) => _onEnter(false),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animacja powiększenia obrazu
            ScaleTransition(
              scale: Tween(begin: 1.0, end: 1.1).animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.easeInOut,
              )),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            // Kontener dla tekstu pojawiający się na środku obrazu
            AnimatedOpacity(
              opacity: _isHovered ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
