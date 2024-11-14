import 'package:flutter/material.dart';
import 'dart:async';
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
  late Animation<double> _fadeInAnimation;
  late List<Animation<double>> _cardOpacities;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FadeTransition(
          opacity: _fadeInAnimation,
          child: Column(
            children: [
              Text(
                widget.isPolish
                    ? 'Pasja do tworzenia przestrzeni'
                    : 'A passion for creating spaces',
                textAlign: TextAlign.center,
                style: GoogleFonts.dancingScript(
                  fontSize: 125,
                  fontWeight: FontWeight.w700,
                  color: widget.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.isPolish
                    ? 'Nasz kompleksowy pakiet usług skierowany jest do szerokiej gamy klientów, od właścicieli domów po deweloperów komercyjnych.'
                    : 'Our comprehensive suite of professional services caters to a diverse clientele, ranging from homeowners to commercial developers.',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: widget.color,
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
        const SizedBox(height: 15),
        LayoutBuilder(
          builder: (context, constraints) {
            double itemWidth = constraints.maxWidth / 3 - 40; // Szerokość karty
            return Center(
              child: Wrap(
                spacing: 16,
                runSpacing: 40, // Większy odstęp między rzędami
                alignment: WrapAlignment.center,
                children: [
                  // Pierwszy rząd kart
                  FadeTransition(
                    opacity: _cardOpacities[0],
                    child: _buildServiceCard(
                      title: _getTitle(0),
                      description: _getDescription(0),
                      delay: 0,
                      width: itemWidth,
                      color: widget.color,
                    ),
                  ),
                  FadeTransition(
                    opacity: _cardOpacities[1],
                    child: _buildServiceCard(
                      title: _getTitle(1),
                      description: _getDescription(1),
                      delay: 0,
                      width: itemWidth,
                      color: widget.color,
                    ),
                  ),
                  FadeTransition(
                    opacity: _cardOpacities[2],
                    child: _buildServiceCard(
                      title: _getTitle(2),
                      description: _getDescription(2),
                      delay: 0,
                      width: itemWidth,
                      color: widget.color,
                    ),
                  ),
                  // Drugi rząd kart z odstępem
                  FadeTransition(
                    opacity: _cardOpacities[3],
                    child: _buildServiceCard(
                      title: _getTitle(3),
                      description: _getDescription(3),
                      delay: 0,
                      width: itemWidth,
                      color: widget.color,
                    ),
                  ),
                  FadeTransition(
                    opacity: _cardOpacities[4],
                    child: _buildServiceCard(
                      title: _getTitle(4),
                      description: _getDescription(4),
                      delay: 0,
                      width: itemWidth,
                      color: widget.color,
                    ),
                  ),
                  FadeTransition(
                    opacity: _cardOpacities[5],
                    child: _buildServiceCard(
                      title: _getTitle(5),
                      description: _getDescription(5),
                      delay: 0,
                      width: itemWidth,
                      color: widget.color,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  String _getTitle(int index) {
    return widget.isPolish
        ? [
            'Renowacja',
            'Ciągłe wsparcie',
            'Dostęp do aplikacji',
            'Doradztwo',
            'Zarządzanie projektami',
            'Rozwiązania architektoniczne'
          ][index]
        : [
            'Renovation',
            'Continuous Support',
            'App Access',
            'Consulting',
            'Project Management',
            'Architectural Solutions'
          ][index];
  }

  String _getDescription(int index) {
    return widget.isPolish
        ? [
            'Odświeżamy przestrzenie i przywracamy im dawną świetność.',
            'Zapewniamy wsparcie na każdym etapie realizacji projektu.',
            'Nasze aplikacje ułatwiają zarządzanie projektami.',
            'Profesjonalne doradztwo dostosowane do indywidualnych potrzeb.',
            'Efektywne zarządzanie projektami dla zapewnienia sukcesu.',
            'Kreatywne i funkcjonalne rozwiązania architektoniczne.'
          ][index]
        : [
            'We refresh spaces and restore their former glory.',
            'We provide support at every stage of the project.',
            'Our apps make project management easier.',
            'Professional consulting tailored to individual needs.',
            'Efficient project management for guaranteed success.',
            'Creative and functional architectural solutions.'
          ][index];
  }

  Widget _buildServiceCard({
    required String title,
    required String description,
    required int delay,
    required double width,
    required Color color,
  }) {
    return SizedBox(
      width: width,
      child: _ServiceCard(
        title: title,
        description: description,
        delay: delay,
        color: color,
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final String title;
  final String description;
  final int delay;
  final Color color;

  const _ServiceCard({
    Key? key,
    required this.title,
    required this.description,
    required this.delay,
    required this.color,
  }) : super(key: key);

  @override
  __ServiceCardState createState() => __ServiceCardState();
}

class __ServiceCardState extends State<_ServiceCard>
    with SingleTickerProviderStateMixin {
  bool isVisible = false;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: widget.delay), () {
      setState(() {
        isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.star, size: 40),
                SizedBox(height: 10),
                Text("Title", style: TextStyle(fontSize: 18)),
                SizedBox(height: 6),
                Text("Description", style: TextStyle(fontSize: 13)),
                SizedBox(width: 6),
              ],
            ),
          ),
          Transform.scale(
            scale: isHovered ? 1.05 : 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  size: 40,
                  color: isHovered ? Colors.amber : widget.color,
                ),
                const SizedBox(height: 10),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutExpo,
                  style: GoogleFonts.montserrat(
                    fontSize: isHovered ? 18 : 16,
                    fontWeight: FontWeight.w500,
                    color: widget.color,
                  ),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 6),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutExpo,
                  style: GoogleFonts.openSans(
                    fontSize: isHovered ? 15 : 13,
                    fontWeight: FontWeight.w400,
                    color: widget.color,
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
        ],
      ),
    );
  }
}
