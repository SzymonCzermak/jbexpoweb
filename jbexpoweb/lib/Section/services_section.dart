import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServicesSection extends StatefulWidget {
  final bool isPolish;
  final Color color;

  const ServicesSection({
    Key? key,
    required this.isPolish,
    this.color = const Color.fromARGB(255, 185, 185, 185),
  }) : super(key: key);

  @override
  _ServicesSectionState createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection>
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
    final double screenHeight = MediaQuery.of(context).size.height;

    // Obliczenie dynamicznego odstępu
    final double topSpacing = screenWidth < 600
        ? 20.0
        : screenHeight * 0.05; // Większa przerwa dla większych ekranów

    final double titleFontSize = screenWidth * 0.07;
    final double subtitleFontSize = screenWidth * 0.03;
    final double cardTitleFontSize = screenWidth * 0.035;
    final double cardDescriptionFontSize = screenWidth * 0.025;
    final double iconSize = screenWidth < 300
        ? 12.0 // Bardzo małe gwiazdki na małych ekranach
        : (screenWidth < 400
            ? 20.0 // Średni rozmiar gwiazdek
            : 30.0); // Duży rozmiar na większych ekranach

    // Dynamika układu
    final int columns = screenWidth < 600 ? 2 : 3;
    final double spacing = screenWidth < 600 ? 10 : 20;
    final double runSpacing =
        screenWidth < 600 ? 15 : 100; // Dynamiczny odstęp między wierszami

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: topSpacing), // Dynamiczny odstęp od góry
        FadeTransition(
          opacity: _controller,
          child: Column(
            children: [
              Text(
                widget.isPolish
                    ? 'Pasja do tworzenia przestrzeni'
                    : 'A passion for creating spaces',
                textAlign: TextAlign.center,
                style: GoogleFonts.dancingScript(
                  fontSize: titleFontSize.clamp(45.0, 120.0),
                  fontWeight: FontWeight.w700,
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
        style: GoogleFonts.openSans(
          fontSize: subtitleFontSize.clamp(1.0, 18.0),
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: widget.color, // Domyślny kolor
        ),
      ),
      TextSpan(
        text: widget.isPolish
            ? 'skierowany jest do szerokiej gamy klientów, '
            : 'caters to a diverse clientele, ',
        style: GoogleFonts.openSans(
          fontSize: subtitleFontSize.clamp(1.0, 18.0),
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: const Color.fromARGB(255, 161, 151, 0), // Wyróżniony kolor
        ),
      ),
      TextSpan(
        text: widget.isPolish
            ? 'od właścicieli domów po deweloperów komercyjnych.'
            : 'ranging from homeowners to commercial developers.',
        style: GoogleFonts.openSans(
          fontSize: subtitleFontSize.clamp(1.0, 18.0),
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: widget.color, // Domyślny kolor
        ),
      ),
    ],
  ),
),

              const SizedBox(height: 35),
            ],
          ),
        ),
        SizedBox(
          height: screenWidth < 600
              ? 1 // Mniejsza przerwa na małych ekranach
              : 40, // Większa przerwa na dużych ekranach
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            double itemWidth = (constraints.maxWidth / columns) - spacing;

            return Wrap(
              spacing: spacing,
              runSpacing: runSpacing, // Zmienny odstęp między wierszami
              alignment: WrapAlignment.center,
              children: [
                for (int i = 0; i < 6; i++)
                  FadeTransition(
                    opacity: _cardOpacities[i],
                    child: SizedBox(
                      width: itemWidth,
                      child: _ServiceCard(
                        title: _getTitle(i),
                        description: _getDescription(i),
                        color: widget.color,
                        cardTitleFontSize: cardTitleFontSize,
                        cardDescriptionFontSize: cardDescriptionFontSize,
                        iconSize: iconSize,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
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
            'We achieve excellent results in a short time',
            'Professional consulting tailored to individual needs.',
            'Efficient project management for guaranteed success.',
            'We offer the highest quality services and full commitment to every project.'
          ][index];
  }
}

class _ServiceCard extends StatefulWidget {
  final String title;
  final String description;
  final Color color;
  final double cardTitleFontSize;
  final double cardDescriptionFontSize;
  final double iconSize;

  const _ServiceCard({
    Key? key,
    required this.title,
    required this.description,
    required this.color,
    required this.cardTitleFontSize,
    required this.cardDescriptionFontSize,
    required this.iconSize,
  }) : super(key: key);

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool isHovered = false; // Flaga dla efektu najechania

  void _onHover(bool hovering) {
    setState(() {
      isHovered = hovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onHover(!isHovered), // Kliknięcie na ekranach dotykowych
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: AnimatedScale(
          scale: isHovered ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                size: widget.iconSize.clamp(6.0, 30.0),
                color:
                    isHovered ? Color.fromARGB(255, 194, 181, 0) : widget.color,
              ),
              const SizedBox(height: 10),
              AnimatedDefaultTextStyle(
                style: GoogleFonts.montserrat(
                  fontSize: widget.cardTitleFontSize.clamp(8.0, 20.0),
                  fontWeight: isHovered ? FontWeight.bold : FontWeight.w500,
                  color: isHovered
                      ? Color.fromARGB(255, 194, 181, 0)
                      : widget.color,
                ),
                duration: const Duration(milliseconds: 200),
                child: Text(widget.title, textAlign: TextAlign.center),
              ),
              const SizedBox(height: 8),
              AnimatedDefaultTextStyle(
                style: GoogleFonts.openSans(
                  fontSize: widget.cardDescriptionFontSize.clamp(6.0, 16.0),
                  fontWeight: isHovered ? FontWeight.w600 : FontWeight.w400,
                  color: isHovered
                      ? Color.fromARGB(255, 194, 181, 0)
                      : widget.color,
                  height: 1.4,
                ),
                duration: const Duration(milliseconds: 200),
                child: Text(widget.description, textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
