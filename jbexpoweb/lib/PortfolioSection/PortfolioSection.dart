import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:dyn_mouse_scroll/dyn_mouse_scroll.dart'; // Import biblioteki
import 'package:jbexpoweb/FooterWidget.dart'; // Import stopki

class PortfolioPage extends StatefulWidget {
  final bool isPolish;

  const PortfolioPage({Key? key, required this.isPolish}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final List<Map<String, String>> _projects = List.generate(
    21, // Liczba zdjęć: 21
    (index) => {
      "imagePath": 'assets/Stoiska/${index + 1}.png',
    },
  );

  final List<bool> _hoverStates =
      List.generate(21, (_) => false); // Dostosowanie hoverStates

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final int crossAxisCount = screenWidth < 600
        ? 1
        : screenWidth < 900
            ? 2
            : 3;

    return Scaffold(
      body: DynMouseScroll(
        builder: (context, controller, physics) => SingleChildScrollView(
          controller: controller,
          physics: physics,
          child: Stack(
            children: [
              // Tło - obraz z zasobów
              Positioned.fill(
                child: Image.asset(
                  'assets/Background3.png',
                  fit: BoxFit.cover,
                ),
              ),
              // Zawartość strony
              Column(
                children: [
                  const SizedBox(height: 60),

                  // Tytuł strony
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // Ustalanie rozmiaru tekstu na podstawie szerokości
                      double titleFontSize = constraints.maxWidth > 800
                          ? 80
                          : 28; // Rozmiar dla dużych i małych ekranów
                      double subtitleFontSize = constraints.maxWidth > 800
                          ? 24
                          : 16; // Mniejszy tekst dla opisu

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Główny tytuł
                          Text(
                            widget.isPolish
                                ? "Nasze Portfolio"
                                : "Our Portfolio",
                            style: GoogleFonts.michroma(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 194, 181, 0),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                              height: 8), // Odstęp między tytułem a podtytułem

                          // Podtytuł
                          Text(
                            widget.isPolish
                                ? "Odzwierciedla naszą pasję, doświadczenie oraz profesjonalizm"
                                : "Spaces that shape your brand's image",
                            style: GoogleFonts.michroma(
                              fontSize: subtitleFontSize,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Divider(
                      color: Color.fromARGB(255, 255, 255, 255), // Kolor kreski
                      thickness: 2, // Grubość kreski
                      indent: 50, // Wcięcie od lewej
                      endIndent: 50, // Wcięcie od prawej
                    ),
                  ),

                  // Galeria zdjęć
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(
                          maxWidth: 1200), // Ograniczenie szerokości
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 1,
                        ),
                        itemCount: _projects.length,
                        itemBuilder: (context, index) {
                          return _buildGridItem(
                            imagePath: _projects[index]['imagePath']!,
                            isHovered: _hoverStates[index],
                            onHover: (hovered) {
                              setState(() {
                                _hoverStates[index] = hovered;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Divider(
                      color: Color.fromARGB(255, 255, 255, 255), // Kolor kreski
                      thickness: 2, // Grubość kreski
                      indent: 50, // Wcięcie od lewej
                      endIndent: 50, // Wcięcie od prawej
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Stopka
                  const FooterWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem({
    required String imagePath,
    required bool isHovered,
    required Function(bool) onHover,
  }) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: () {
          _showFullScreenImage(imagePath);
        },
        child: AnimatedScale(
          scale: isHovered ? 1.05 : 1.0, // Powiększenie przy najechaniu
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color.fromARGB(134, 194, 181, 0),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFullScreenImage(String imagePath) {
    showDialog(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
