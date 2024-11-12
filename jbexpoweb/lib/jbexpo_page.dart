import 'package:flutter/material.dart';
import 'package:jbexpoweb/Section/tree_image_section.dart';
import 'package:jbexpoweb/Section/services_section.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class JBExpoPage extends StatefulWidget {
  const JBExpoPage({super.key});

  @override
  State<JBExpoPage> createState() => _JBExpoPageState();
}

class _JBExpoPageState extends State<JBExpoPage> {
  bool isPolish = true;
  final PageController _pageController = PageController();

  void _toggleLanguage(bool value) {
    setState(() {
      isPolish = value;
    });
  }

  void _navigateTo(String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Przejdź do: $section')),
    );
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
                image: AssetImage('assets/background_image.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.6),
                  BlendMode.softLight,
                ),
              ),
            ),
          ),
          Column(
            children: [
              // Gradient AppBar
              AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/JBExpoLogo.png',
                      height: 40.0,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'JB Expo Plus',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFFFFFF), // White
                        Color(0xFF190F51), // Dark purple
                        Color(0xFFDC272D), // Red
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                actions: [
                  Row(
                    children: [
                      const Text("PL"),
                      Switch(
                        value: isPolish,
                        onChanged: _toggleLanguage,
                        activeColor: Colors.white,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                      ),
                      const Text("EN"),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: ServicesSection(isPolish: isPolish),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: const ThreeImageSection(),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isPolish
                                ? 'Profesjonalne usługi wystawiennicze'
                                : 'Professional Exhibition Services',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            isPolish
                                ? 'JB Expo Plus dostarcza rozwiązania wystawiennicze najwyższej jakości dla różnych branż.'
                                : 'JB Expo Plus provides top-quality exhibition solutions for various industries.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                dotColor: Colors.grey.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
