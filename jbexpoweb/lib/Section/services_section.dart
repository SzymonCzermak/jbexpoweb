import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

class ServicesSection extends StatefulWidget {
  final bool isPolish;

  const ServicesSection({Key? key, required this.isPolish}) : super(key: key);

  @override
  _ServicesSectionState createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

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
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.isPolish
                    ? 'Nasz kompleksowy pakiet usług skierowany jest do szerokiej gamy klientów, od właścicieli domów po deweloperów komercyjnych.'
                    : 'Our comprehensive suite of professional services caters to a diverse clientele, ranging from homeowners to commercial developers.',
                textAlign: TextAlign.center,
                style: GoogleFonts.dancingScript(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
        const SizedBox(height: 32),
        LayoutBuilder(
          builder: (context, constraints) {
            double itemWidth = constraints.maxWidth / 3 - 20;
            return Wrap(
              spacing: 16,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _buildServiceCard(
                  title: widget.isPolish ? 'Renowacja' : 'Renovation',
                  description: widget.isPolish
                      ? 'Odświeżamy przestrzenie i przywracamy im dawną świetność.'
                      : 'We refresh spaces and restore their former glory.',
                  delay: 0,
                  width: itemWidth,
                ),
                _buildServiceCard(
                  title: widget.isPolish
                      ? 'Ciągłe wsparcie'
                      : 'Continuous Support',
                  description: widget.isPolish
                      ? 'Zapewniamy wsparcie na każdym etapie realizacji projektu.'
                      : 'We provide support at every stage of the project.',
                  delay: 200,
                  width: itemWidth,
                ),
                _buildServiceCard(
                  title: widget.isPolish ? 'Dostęp do aplikacji' : 'App Access',
                  description: widget.isPolish
                      ? 'Nasze aplikacje ułatwiają zarządzanie projektami.'
                      : 'Our apps make project management easier.',
                  delay: 400,
                  width: itemWidth,
                ),
                SizedBox(
                  height: 125,
                ),
                _buildServiceCard(
                  title: widget.isPolish ? 'Doradztwo' : 'Consulting',
                  description: widget.isPolish
                      ? 'Profesjonalne doradztwo dostosowane do indywidualnych potrzeb.'
                      : 'Professional consulting tailored to individual needs.',
                  delay: 600,
                  width: itemWidth,
                ),
                _buildServiceCard(
                  title: widget.isPolish
                      ? 'Zarządzanie projektami'
                      : 'Project Management',
                  description: widget.isPolish
                      ? 'Efektywne zarządzanie projektami dla zapewnienia sukcesu.'
                      : 'Efficient project management for guaranteed success.',
                  delay: 800,
                  width: itemWidth,
                ),
                _buildServiceCard(
                  title: widget.isPolish
                      ? 'Rozwiązania architektoniczne'
                      : 'Architectural Solutions',
                  description: widget.isPolish
                      ? 'Kreatywne i funkcjonalne rozwiązania architektoniczne.'
                      : 'Creative and functional architectural solutions.',
                  delay: 1000,
                  width: itemWidth,
                ),
                SizedBox(
                  height: 125,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String description,
    required int delay,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: _ServiceCard(
        title: title,
        description: description,
        delay: delay,
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final String title;
  final String description;
  final int delay;

  const _ServiceCard({
    Key? key,
    required this.title,
    required this.description,
    required this.delay,
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        transformAlignment: Alignment.center, // Ustawienie skalowania na środek
        transform: isHovered
            ? Matrix4.identity().scaled(1.05, 1.05, 1.05)
            : Matrix4.identity(),
        curve: Curves.easeOutExpo,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 40,
              color: isHovered ? Colors.amber : Colors.grey.shade600,
            ),
            const SizedBox(height: 10),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutExpo,
              style: GoogleFonts.montserrat(
                fontSize: isHovered ? 18 : 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
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
                color: Colors.black87,
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
    );
  }
}
