import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PassionSection extends StatefulWidget {
  final bool isPolish;

  const PassionSection({
    Key? key,
    required this.isPolish,
  }) : super(key: key);

  @override
  _PassionSectionState createState() => _PassionSectionState();
}

class _PassionSectionState extends State<PassionSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimationHeader;
  late Animation<Offset> _slideAnimationHeader;
  late Animation<double> _opacityAnimationText;
  late Animation<double> _widthAnimation;
  late List<Animation<double>> _cardOpacities;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _opacityAnimationHeader = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _slideAnimationHeader =
        Tween<Offset>(begin: const Offset(0, 1.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _opacityAnimationText = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _widthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.80, 1.0, curve: Curves.easeInOut),
      ),
    );

    _cardOpacities = List.generate(6, (index) {
      final startInterval = 0.4 + (index * 0.1);
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(startInterval, startInterval + 0.2,
              curve: Curves.easeIn),
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;
    final int columns = isSmallScreen ? 2 : 3; // Kolumny zależne od ekranu
    final double iconSize = isSmallScreen ? 20.0 : 40.0;

    // Dynamiczne marginesy
    final double horizontalPadding = isSmallScreen ? 16.0 : screenWidth * 0.1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _slideAnimationHeader,
              child: FadeTransition(
                opacity: _opacityAnimationHeader,
                child: Text(
                  widget.isPolish
                      ? 'Pasja do tworzenia przestrzenii'
                      : 'A passion for creating spaces',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.michroma(
                    fontSize: isSmallScreen ? 32.0 : 80.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 216, 216, 216),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            FadeTransition(
              opacity: _opacityAnimationText,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.isPolish
                          ? 'Nasz kompleksowy pakiet usług '
                          : 'Our comprehensive suite of professional services ',
                      style: GoogleFonts.michroma(
                        fontSize: isSmallScreen ? 12.0 : 18.0,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: const Color.fromARGB(255, 216, 216, 216),
                      ),
                    ),
                    TextSpan(
                      text: widget.isPolish
                          ? 'skierowany jest do szerokiej gamy klientów, '
                          : 'caters to a diverse clientele, ',
                      style: GoogleFonts.michroma(
                        fontSize: isSmallScreen ? 12.0 : 18.0,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: const Color.fromARGB(255, 161, 151, 0),
                      ),
                    ),
                    TextSpan(
                      text: widget.isPolish
                          ? 'od właścicieli domów po deweloperów komercyjnych.'
                          : 'ranging from homeowners to commercial developers.',
                      style: GoogleFonts.michroma(
                        fontSize: isSmallScreen ? 12.0 : 18.0,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: const Color.fromARGB(255, 216, 216, 216),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _widthAnimation,
              builder: (context, child) {
                return Container(
                  width: _widthAnimation.value * screenWidth * 0.8,
                  height: 2,
                  color: const Color.fromARGB(255, 255, 255, 255),
                );
              },
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                double itemWidth =
                    (constraints.maxWidth - (columns - 1) * 20) / columns;

                return Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: [
                    for (int i = 0; i < 6; i++)
                      FadeTransition(
                        opacity: _cardOpacities[i],
                        child: SizedBox(
                          width: itemWidth,
                          child: _AnimatedServiceCard(
                            title: _getTitle(i),
                            description: _getDescription(i),
                            iconSize: iconSize,
                          ),
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

  String _getTitle(int index) {
    return widget.isPolish
        ? [
            'Kreatywność',
            'Ciągłe wsparcie',
            'Wydajność',
            'Doradztwo',
            'Zarządzanie ',
            'Profesjonalizm'
          ][index]
        : [
            'Creativity',
            'Support',
            'Efficiency',
            'Consulting',
            'Management',
            'Professionalism'
          ][index];
  }

  String _getDescription(int index) {
    return widget.isPolish
        ? [
            'Tworzymy innowacyjne rozwiązania na miarę przyszłości.',
            'Zapewniamy wsparcie na każdym etapie realizacji projektu.',
            'Osiągamy doskonałe wyniki w krótkim czasie.',
            'Profesjonalne doradztwo dostosowane do indywidualnych potrzeb.',
            'Efektywne zarządzanie projektami dla zapewnienia sukcesu.',
            'Oferujemy najwyższą jakość usług i pełne zaangażowanie w każdy projekt.'
          ][index]
        : [
            'We create innovative solutions for the future.',
            'We provide support at every stage of the project.',
            'We achieve excellent results in a short time.',
            'Professional consulting tailored to individual needs.',
            'Efficient project management for guaranteed success.',
            'We offer the highest quality services and full commitment to every project.'
          ][index];
  }
}

class _AnimatedServiceCard extends StatefulWidget {
  final String title;
  final String description;
  final double iconSize;

  const _AnimatedServiceCard({
    Key? key,
    required this.title,
    required this.description,
    required this.iconSize,
  }) : super(key: key);

  @override
  __AnimatedServiceCardState createState() => __AnimatedServiceCardState();
}

class __AnimatedServiceCardState extends State<_AnimatedServiceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _colorAnimation = ColorTween(
      begin: const Color.fromARGB(255, 216, 216, 216),
      end: const Color.fromARGB(255, 255, 215, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _colorAnimation,
                builder: (context, child) {
                  return Icon(
                    Icons.star,
                    size: widget.iconSize,
                    color: _colorAnimation.value,
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.michroma(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 216, 216, 216),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: GoogleFonts.michroma(
                  fontSize: isSmallScreen ? 8.0 : 12.0,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 216, 216, 216),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
