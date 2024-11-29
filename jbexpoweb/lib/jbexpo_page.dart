import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jbexpoweb/Section/third_section.dart';
import 'package:jbexpoweb/Section/tree_image_section.dart';
import 'package:jbexpoweb/Section/welcome_section.dart';
import 'package:jbexpoweb/Section/services_section.dart';
import 'package:jbexpoweb/contact_dialog.dart';
import 'package:jbexpoweb/team_dialog.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jbexpoweb/responsive_appbar.dart';

class JBExpoPage extends StatefulWidget {
  const JBExpoPage({super.key});

  @override
  State<JBExpoPage> createState() => _JBExpoPageState();
}

class _JBExpoPageState extends State<JBExpoPage> {
  bool isPolish = true;
  final PageController _pageController = PageController();
  bool isScrolling = false;

  void _toggleLanguage(bool value) {
    setState(() {
      isPolish = value;
    });
  }

  void _handleScroll(double delta, {required bool isMouse}) {
    if (!isScrolling) {
      isScrolling = true;

      if (isMouse) {
        // Dla myszki naturalny kierunek przewijania
        if (delta > 0) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else if (delta < 0) {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      } else {
        // Dla dotyku odwrotny kierunek
        if (delta < 0) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else if (delta > 0) {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }

      Future.delayed(const Duration(milliseconds: 300), () {
        isScrolling = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Background2.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  const Color.fromARGB(255, 0, 0, 0).withOpacity(0.0),
                  BlendMode.softLight,
                ),
              ),
            ),
          ),
          Column(
            children: [
              // AppBar
              ResponsiveAppBar(
                isPolish: isPolish,
                toggleLanguage: _toggleLanguage,
              ),
              Expanded(
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    // Obsługa gestów dotykowych
                    _handleScroll(details.primaryDelta ?? 0, isMouse: false);
                  },
                  child: Listener(
                    onPointerSignal: (pointerSignal) {
                      if (pointerSignal is PointerScrollEvent) {
                        // Obsługa przewijania myszką
                        _handleScroll(pointerSignal.scrollDelta.dy,
                            isMouse: true);
                      }
                    },
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: 4, // Zwiększ liczbę elementów
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              child: ServicesSection(isPolish: isPolish),
                            );
                          case 1:
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              child: WelcomeSection(
                                  isPolish: isPolish), // Nowa sekcja
                            );
                          case 2:
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleImageSection(isPolish: isPolish),
                            );
                          case 3:
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              child: ThirdSection(isPolish: isPolish),
                            );
                          default:
                            return const SizedBox();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Vertical Page Indicator
          Positioned(
            right: 16,
            top: MediaQuery.of(context).size.height / 2 - 40,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              axisDirection: Axis.vertical,
              effect: WormEffect(
                activeDotColor: Colors.redAccent,
                dotHeight: 12,
                dotWidth: 12,
                spacing: 16,
                dotColor: Color.fromARGB(255, 117, 117, 117).withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
