import 'package:flutter/material.dart';

class ThreeImageSection extends StatefulWidget {
  final bool isPolish;

  const ThreeImageSection({super.key, required this.isPolish});

  @override
  _ThreeImageSectionState createState() => _ThreeImageSectionState();
}

class _ThreeImageSectionState extends State<ThreeImageSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _titleOpacity;
  late Animation<double> _subTitleOpacity;
  late List<Animation<double>> _imageOpacities;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.2)),
    );

    _subTitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.4)),
    );

    _imageOpacities = List.generate(3, (index) {
      final startInterval = 0.4 + (index * 0.2);
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(startInterval, startInterval + 0.2),
        ),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              FadeTransition(
                opacity: _titleOpacity,
                child: Text(
                  widget.isPolish
                      ? 'Nasze realizacje na światowych targach'
                      : 'Our showcases at global trade fairs',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 185, 185, 185),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeTransition(
                opacity: _subTitleOpacity,
                child: Text(
                  widget.isPolish
                      ? 'Wyjątkowe projekty dla wyjątkowych klientów.'
                      : 'Unique projects for unique clients.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 185, 185, 185),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (index) {
            return Expanded(
              child: FadeTransition(
                opacity: _imageOpacities[index],
                child: _buildImageCard(
                  'assets/Targi/${index + 1}.png',
                  _getDescription(index),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  String _getDescription(int index) {
    if (index == 0) {
      return widget.isPolish
          ? 'W Madrycie na targach GENERA 2023 zaprezentowaliśmy nasze stoisko z nowoczesnymi modułami solarnymi Tongwei, które spotkały się z ogromnym zainteresowaniem wśród specjalistów branży odnawialnych źródeł energii.'
          : 'At GENERA 2023 in Madrid, we showcased our booth featuring cutting-edge solar modules by Tongwei, which garnered significant interest from renewable energy professionals.';
    } else if (index == 1) {
      return widget.isPolish
          ? 'Na targach IFA Berlin 2024 zaprezentowaliśmy zaawansowane technologie grupy NBD, skupiając się na innowacyjnych rozwiązaniach dla branży technologicznej.'
          : 'At IFA Berlin 2024, we presented the advanced technologies of NBD Group, emphasizing innovative solutions for the tech industry.';
    } else {
      return widget.isPolish
          ? 'W Barcelonie, na MWC 2024, przedstawiliśmy rozwiązania weryfikacji tożsamości firmy Regula, które przyciągnęły uwagę globalnej publiczności, zainteresowanej najnowszymi technologiami bezpieczeństwa.'
          : 'In Barcelona at MWC 2024, we showcased identity verification solutions by Regula, capturing the attention of a global audience interested in the latest security technologies.';
    }
  }

  Widget _buildImageCard(String imagePath, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45.0),
      child: HoverImageCard(
        imagePath: imagePath,
        description: description,
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
      duration: const Duration(milliseconds: 150),
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
                      color: Color.fromARGB(255, 185, 185, 185),
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
