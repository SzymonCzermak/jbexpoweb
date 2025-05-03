import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jbexpoweb/MainSection/EndSection.dart';
import 'package:jbexpoweb/MainSection/PartnerSection.dart';
import 'package:jbexpoweb/MainSection/S1Section.dart';
import 'package:jbexpoweb/MainSection/S2Section.dart';
import 'package:jbexpoweb/MainSection/WelcomeSection.dart';
import 'package:jbexpoweb/MainSection/VideoSection.dart';
import 'package:jbexpoweb/MainSection/PortfolioSec.dart';
import 'package:jbexpoweb/MainSection/PassionSection.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class JBExpoPage extends StatefulWidget {
  final bool isPolish;
  final Function(int) onNavigate; // Dodanie onNavigate jako parametru

  const JBExpoPage({
    Key? key,
    required this.isPolish,
    required this.onNavigate, // Dodanie onNavigate w konstruktorze
  }) : super(key: key);

  @override
  State<JBExpoPage> createState() => _JBExpoPageState();
}

class _JBExpoPageState extends State<JBExpoPage> {
  final PageController _pageController = PageController();
  bool isScrolling = false;

  void _handleScroll(double delta, {required bool isMouse}) async {
    if (!isScrolling) {
      isScrolling = true;

      if (isMouse) {
        if (delta > 0) {
          await _pageController.nextPage(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          );
        } else if (delta < 0) {
          await _pageController.previousPage(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          );
        }
      } else {
        if (delta < 0) {
          await _pageController.nextPage(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          );
        } else if (delta > 0) {
          await _pageController.previousPage(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          );
        }
      }

      await Future.delayed(const Duration(milliseconds: 550));
      isScrolling = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Background3.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        GestureDetector(
          onVerticalDragUpdate: (details) {
            _handleScroll(details.primaryDelta ?? 0, isMouse: false);
          },
          child: Listener(
            onPointerSignal: (pointerSignal) {
              if (pointerSignal is PointerScrollEvent) {
                _handleScroll(pointerSignal.scrollDelta.dy, isMouse: true);
              }
            },
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 8, // Liczba sekcji
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return const VideoSection();
                  case 4:
                    return S1Section(isPolish: widget.isPolish);
                  case 1:
                    return WelcomeSection(isPolish: widget.isPolish);
                  case 2:
                    return PassionSection(isPolish: widget.isPolish);
                  case 3:
                    return PartnerSection(isPolish: widget.isPolish);
                  case 5:
                    return S2Section(isPolish: widget.isPolish);
                  case 6:
                    return PortfolioSec(
                      isPolish: widget.isPolish,
                      onNavigate: widget.onNavigate, // Przekazanie onNavigate
                    );
                  case 7:
                    return EndSection(
                      isPolish: widget.isPolish,
                    ); // Zamiana FooterWidget na EndSection
                  default:
                    return const SizedBox();
                }
              },
            ),
          ),
        ),
        Positioned(
          right: 16,
          top: MediaQuery.of(context).size.height / 2 - 40,
          child: SmoothPageIndicator(
            controller: _pageController,
            count: 5, // Zwiększamy liczbę sekcji o stopkę
            axisDirection: Axis.vertical,
            effect: WormEffect(
              activeDotColor: Colors.redAccent,
              dotHeight: 12,
              dotWidth: 12,
              spacing: 16,
              dotColor:
                  const Color.fromARGB(255, 117, 117, 117).withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
