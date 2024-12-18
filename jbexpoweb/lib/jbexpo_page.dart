import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jbexpoweb/Section/PartnerSection.dart';
import 'package:jbexpoweb/Section/VideoSection.dart';
import 'package:jbexpoweb/Section/TransportSection.dart';
import 'package:jbexpoweb/Section/PassionSection.dart';
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

  void _handleScroll(double delta, {required bool isMouse}) async {
    if (!isScrolling) {
      isScrolling = true;

      if (isMouse) {
        // Naturalny kierunek dla myszki
        if (delta > 0) {
          // Przewijanie w dół
          await _pageController.nextPage(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          );
        } else if (delta < 0) {
          // Przewijanie w górę
          await _pageController.previousPage(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          );
        }
      } else {
        // Odwrotny kierunek dla dotyku
        if (delta < 0) {
          // Przewijanie w dół
          await _pageController.nextPage(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          );
        } else if (delta > 0) {
          // Przewijanie w górę
          await _pageController.previousPage(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          );
        }
      }

      // Blokada przewijania na 500 ms
      await Future.delayed(const Duration(milliseconds: 550));
      isScrolling = false;
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
                image: AssetImage('assets/Background3.png'),
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
        toggleLanguage: (newValue) {
          setState(() {
            isPolish = newValue;
          });
        },
        pageController: _pageController, // Przekazano kontroler
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
                      itemCount: 6, // Zwiększ liczbę elementów
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 1:
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              child: PassionSection(isPolish: isPolish),
                            );
                          case 3:
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              child: TransportSection(isPolish: isPolish),
                            );
                          case 2:
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              child: PartnerSection(isPolish: isPolish),
                            );
                          case 0: // Nowa sekcja z wideo
                            return const VideoSection();
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
              count: 6,
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
