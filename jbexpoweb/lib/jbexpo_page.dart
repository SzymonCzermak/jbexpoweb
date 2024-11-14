import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jbexpoweb/Section/third_section.dart';
import 'package:jbexpoweb/Section/tree_image_section.dart';
import 'package:jbexpoweb/Section/services_section.dart';
import 'package:jbexpoweb/contact_dialog.dart';
import 'package:jbexpoweb/team_dialog.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class JBExpoPage extends StatefulWidget {
  const JBExpoPage({super.key});

  @override
  State<JBExpoPage> createState() => _JBExpoPageState();
}

class _JBExpoPageState extends State<JBExpoPage> {
  bool isPolish = true;
  final PageController _pageController = PageController();
  bool isScrolling = false; // Flaga, by uniknąć podwójnego przewijania

  void _toggleLanguage(bool value) {
    setState(() {
      isPolish = value;
    });
  }

  void _scrollToNextPage() {
    if (!isScrolling) {
      isScrolling = true;
      final nextPage = (_pageController.page ?? 0).toInt() + 1;
      if (nextPage < 3) {
        _pageController
            .animateToPage(
              nextPage,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            )
            .then((_) => isScrolling = false); // Reset flagi po zakończeniu
      } else {
        isScrolling = false; // Reset jeśli ostatnia strona
      }
    }
  }

  void _scrollToPreviousPage() {
    if (!isScrolling) {
      isScrolling = true;
      final previousPage = (_pageController.page ?? 0).toInt() - 1;
      if (previousPage >= 0) {
        _pageController
            .animateToPage(
              previousPage,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            )
            .then((_) => isScrolling = false); // Reset flagi po zakończeniu
      } else {
        isScrolling = false; // Reset jeśli pierwsza strona
      }
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
                image: AssetImage('assets/Background.png'),
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
              AppBar(
                backgroundColor: const Color.fromARGB(172, 0, 0, 0),
                elevation: 0,
                centerTitle: false,
                title: Padding(
                  padding: const EdgeInsets.only(left: 80.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/JBExpoLogo.png',
                        height: 200.0,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ContactDialog(
                                isPolish: isPolish,
                                borderGradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 0, 54, 148),
                                    Color.fromARGB(255, 114, 0, 0),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          isPolish ? "Kontakt" : "Contact",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return TeamDialog(
                                isPolish: isPolish,
                                borderGradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 0, 54, 148),
                                    Color.fromARGB(255, 114, 0, 0),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          isPolish ? "Nasz Zespół" : "Our Team",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 80.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.public, // Ikona globusa
                                color: Color.fromARGB(255, 157, 4, 177),
                                size: 30,
                              ),
                              onPressed: () {
                                const fbUrl = 'https://g.co/kgs/9fbbLNN';
                                launch(fbUrl);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.facebook,
                                color:
                                    Colors.blueAccent, // Kolor ikony Facebooka
                                size: 30, // Dopasuj rozmiar ikony
                              ),
                              onPressed: () {
                                const fbUrl =
                                    'https://www.facebook.com/profile.php?id=100088078372925';
                                launch(fbUrl);
                              },
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            SvgPicture.asset(
                              'packages/country_icons/icons/flags/svg/gb.svg',
                              width: 18,
                              height: 18,
                            ),
                            const SizedBox(width: 4),
                          ],
                        ),
                        Switch(
                          value: isPolish,
                          onChanged: _toggleLanguage,
                          activeColor: Colors.white,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 4),
                            SvgPicture.asset(
                              'packages/country_icons/icons/flags/svg/pl.svg',
                              width: 18,
                              height: 18,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Expanded(
                child: Listener(
                  onPointerSignal: (pointerSignal) {
                    if (pointerSignal is PointerScrollEvent) {
                      if (pointerSignal.scrollDelta.dy > 0) {
                        _scrollToNextPage();
                      } else if (pointerSignal.scrollDelta.dy < 0) {
                        _scrollToPreviousPage();
                      }
                    }
                  },
                  child: PageView(
                    controller: _pageController,
                    physics:
                        const NeverScrollableScrollPhysics(), // Blokada przewijania ręcznego
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: ServicesSection(isPolish: isPolish),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: ThreeImageSection(isPolish: isPolish),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: ThirdSection(isPolish: isPolish), // Nowa sekcja
                      ),
                    ],
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
          // Floating Action Buttons for scroll control
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 52,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    onPressed: _scrollToPreviousPage,
                    backgroundColor: const Color.fromARGB(137, 59, 59, 59),
                    child: const Icon(
                      Icons.keyboard_arrow_up,
                      size: 24,
                      color: Colors.white70,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    onPressed: _scrollToNextPage,
                    backgroundColor: const Color.fromARGB(137, 59, 59, 59),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 24,
                      color: Colors.white70,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
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
