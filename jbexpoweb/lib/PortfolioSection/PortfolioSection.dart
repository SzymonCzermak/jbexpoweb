import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jbexpoweb/responsive_appbar.dart';

class PortfolioPage extends StatefulWidget {
  final bool isPolish;

  const PortfolioPage({Key? key, required this.isPolish}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  late bool isPolish;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    isPolish = widget.isPolish;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void toggleLanguage(bool value) {
    setState(() {
      isPolish = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        onPointerSignal: (pointerSignal) {
          if (pointerSignal is PointerScrollEvent) {
            _scrollController.jumpTo(
              _scrollController.offset + pointerSignal.scrollDelta.dy,
            );
          }
        },
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            _scrollController.jumpTo(
              _scrollController.offset - details.primaryDelta!,
            );
          },
          child: Stack(
            children: [
              // Tło
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Background3.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  // Główna zawartość
                  Expanded(
                    child: ListView(
                      controller: _scrollController,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        const SizedBox(height: 20),
                        _buildSection(
                          title: isPolish ? "Nasze Projekty" : "Our Projects",
                          description: isPolish
                              ? "Oto niektóre z naszych ukończonych projektów."
                              : "Here are some of our completed projects.",
                          imagePath: 'assets/Portfolio/project1.png',
                        ),
                        _buildSection(
                          title:
                              isPolish ? "Kreatywne Pomysły" : "Creative Ideas",
                          description: isPolish
                              ? "Nasze pomysły zmieniają wizje w rzeczywistość."
                              : "Our ideas turn visions into reality.",
                          imagePath: 'assets/Portfolio/project2.png',
                        ),
                        _buildSection(
                          title: isPolish
                              ? "Zadowoleni Klienci"
                              : "Satisfied Clients",
                          description: isPolish
                              ? "Zadowolenie naszych klientów to nasz największy sukces."
                              : "Client satisfaction is our greatest success.",
                          imagePath: 'assets/Portfolio/project3.png',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required String imagePath,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.michroma(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 194, 181, 0),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color.fromARGB(134, 194, 181, 0),
                width: 3,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            description,
            style: GoogleFonts.michroma(
              fontSize: 16,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
