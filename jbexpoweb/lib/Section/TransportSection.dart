import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransportSection extends StatefulWidget {
  final bool isPolish;

  const TransportSection({super.key, required this.isPolish});

  @override
  _SingleImageSectionState createState() => _SingleImageSectionState();
}

class _SingleImageSectionState extends State<TransportSection> {
  bool isHovered = false;

  void _onHover(bool hovering) {
    setState(() {
      isHovered = hovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = screenWidth < 600;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (isMobile) {
          return _buildMobileLayout();
        } else {
          return _buildDesktopLayout();
        }
      },
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        _buildTitle(fontSize: 36),
        const SizedBox(height: 20),
        Expanded(child: _buildImage(reducedSize: 0.9)),
        const SizedBox(height: 20),
        _buildDescription(fontSize: 18),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: _buildImage(reducedSize: 0.8),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(fontSize: 72),
                const SizedBox(height: 20),
                _buildDescription(fontSize: 28),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle({required double fontSize}) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        "TRANSPORT",
        style: GoogleFonts.michroma(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 194, 181, 0),
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(3, 3),
              blurRadius: 6,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage({double reducedSize = 1.0}) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: () => print("Image clicked"),
        child: Transform.scale(
          scale: reducedSize,
          child: Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: Color.fromARGB(134, 194, 181, 0), width: 3),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 97, 90, 0).withOpacity(0.5),
                  blurRadius: 100,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/Targi/1.png',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  opacity: isHovered ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(150, 0, 0, 0),
                          Color.fromARGB(150, 7, 73, 255),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDescription({required double fontSize}) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: GoogleFonts.michroma(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        children: [
          TextSpan(
            text: widget.isPolish
                ? "Organizacja biura pod względem transportu to nasza mocna strona. "
                : "Office organization in terms of transport is our strength. ",
          ),
          TextSpan(
            text: widget.isPolish
                ? "Zapewniamy, że proces załadunku tira przebiega szybko i dokładnie, a towar jest odpowiednio zapakowany."
                : "We ensure that the process of loading a truck is quick and precise, and the goods are properly packaged.",
            style: GoogleFonts.michroma(
              color: const Color.fromARGB(255, 194, 181, 0),
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(2, 2),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
