import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PassionSection extends StatefulWidget {
  final bool isPolish;
  final Color color;

  const PassionSection({
    Key? key,
    required this.isPolish,
    this.color = const Color.fromARGB(255, 216, 216, 216),
  }) : super(key: key);

  @override
  _ServicesSectionState createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<PassionSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _cardOpacities;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _cardOpacities = List.generate(6, (index) {
      final startInterval = 0.2 + (index * 0.1);
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
            FadeTransition(
              opacity: _controller,
              child: Column(
                children: [
                  Text(
                    widget.isPolish
                        ? 'Pasja do tworzenia przestrzeni'
                        : 'A passion for creating spaces',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.michroma(
                      fontSize: isSmallScreen ? 36.0 : 80.0,
                      fontWeight: FontWeight.bold,
                      color: widget.color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.isPolish
                              ? 'Nasz kompleksowy pakiet usług '
                              : 'Our comprehensive suite of professional services ',
                          style: GoogleFonts.michroma(
                            fontSize: isSmallScreen ? 14.0 : 18.0,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            color: widget.color,
                          ),
                        ),
                        TextSpan(
                          text: widget.isPolish
                              ? 'skierowany jest do szerokiej gamy klientów, '
                              : 'caters to a diverse clientele, ',
                          style: GoogleFonts.michroma(
                            fontSize: isSmallScreen ? 14.0 : 18.0,
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
                            fontSize: isSmallScreen ? 14.0 : 18.0,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            color: widget.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Divider(
                      color: Color.fromARGB(255, 255, 255, 255),
                      thickness: 2,
                      indent: 50,
                      endIndent: 50,
                    ),
                  ),
                ],
              ),
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
                            color: widget.color,
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
            'Zarządzanie projektami',
            'Profesjonalizm'
          ][index]
        : [
            'Creativity',
            'Continuous Support',
            'Efficiency',
            'Consulting',
            'Project Management',
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
  final Color color;
  final double iconSize;

  const _AnimatedServiceCard({
    Key? key,
    required this.title,
    required this.description,
    required this.color,
    required this.iconSize,
  }) : super(key: key);

  @override
  State<_AnimatedServiceCard> createState() => _AnimatedServiceCardState();
}

class _AnimatedServiceCardState extends State<_AnimatedServiceCard> {
  bool isHovered = false;

  void _onHover(bool hovering) {
    setState(() {
      isHovered = hovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile =
        screenWidth < 600; // Ekrany o szerokości poniżej 600px

    final double iconSize = isMobile ? widget.iconSize * 0.6 : widget.iconSize;
    final double titleFontSize = isMobile ? 12.0 : 16.0;
    final double descriptionFontSize = isMobile ? 8.0 : 12.0;

    return GestureDetector(
      onTap: () => _onHover(!isHovered),
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: AnimatedScale(
          scale: isHovered ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                size: iconSize,
                color: isHovered
                    ? const Color.fromARGB(255, 194, 181, 0)
                    : widget.color,
              ),
              const SizedBox(
                  height: 8), // Mniejszy odstęp dla mniejszych ekranów
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: GoogleFonts.michroma(
                  fontSize: titleFontSize,
                  fontWeight: isHovered ? FontWeight.bold : FontWeight.w500,
                  color: isHovered
                      ? const Color.fromARGB(255, 194, 181, 0)
                      : widget.color,
                ),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 6), // Mniejszy odstęp dla opisu
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: GoogleFonts.michroma(
                  fontSize: descriptionFontSize,
                  fontWeight: FontWeight.w400,
                  color: isHovered
                      ? const Color.fromARGB(255, 194, 181, 0)
                      : widget.color,
                  height: 1.3,
                ),
                child: Text(
                  widget.description,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
