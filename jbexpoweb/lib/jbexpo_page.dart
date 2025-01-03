import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jbexpoweb/MainSection/ContactUsSection.dart';
import 'package:jbexpoweb/MainSection/PartnerSection.dart';
import 'package:jbexpoweb/MainSection/VideoSection.dart';
import 'package:jbexpoweb/MainSection/TransportSection.dart';
import 'package:jbexpoweb/MainSection/PassionSection.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class JBExpoPage extends StatefulWidget {
  final bool isPolish;

  const JBExpoPage({Key? key, required this.isPolish}) : super(key: key);

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
              itemCount: 5,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return const VideoSection();
                  case 1:
                    return PassionSection(isPolish: widget.isPolish);
                  case 2:
                    return PartnerSection(isPolish: widget.isPolish);
                  case 3:
                    return TransportSection(isPolish: widget.isPolish);
                  case 4:
                    return ContactUsSection(isPolish: widget.isPolish);
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
            count: 5,
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
