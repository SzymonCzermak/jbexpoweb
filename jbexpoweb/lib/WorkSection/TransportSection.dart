import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jbexpoweb/contact_dialog.dart';
import 'package:jbexpoweb/team_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jbexpoweb/responsive_appbar.dart';

class HowWeWorkPage extends StatelessWidget {
  final bool isPolish;

  const HowWeWorkPage({Key? key, required this.isPolish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveAppBar(
        isPolish: isPolish,
        toggleLanguage:
            (value) {}, // Replace with actual implementation if needed
        pageController: PageController(),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Background3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _buildArrowWithNumber(1),
                      _buildAlternatingSection(
                        title: "TRANSPORT",
                        imagePath: 'assets/Team/pigi.png',
                        description: isPolish
                            ? "Organizacja biura pod względem transportu to nasza mocna strona. Zapewniamy, że proces załadunku tira przebiega szybko i dokładnie, a towar jest odpowiednio zapakowany."
                            : "Organization of office transport is our strong point. We ensure that the truck loading process runs quickly and precisely, and the goods are properly packed.",
                        imageOnLeft: false,
                        alignRight: true,
                      ),
                      _buildArrowWithNumber(2),
                      _buildAlternatingSection(
                        title: "MONTAŻ",
                        imagePath: 'assets/Team/pigi.png',
                        description: isPolish
                            ? "Zespół monterów zostaje wysłany bezpośrednio na wydarzenie targowe, gdzie z pełnym zaangażowaniem i pasją montuje stoisko."
                            : "The assembly team is sent directly to the trade event, where they assemble the booth with full commitment and passion.",
                        imageOnLeft: true,
                        alignRight: false,
                      ),
                      _buildArrowWithNumber(3),
                      _buildAlternatingSection(
                        title: "MAGAZYN",
                        imagePath: 'assets/Team/pigi.png',
                        description: isPolish
                            ? "Elementy, które powstają po montażu stoiska, magazynujemy w odpowiednich warunkach, by dbać o porządek i zgodność z normami ekologicznymi."
                            : "The elements created after assembling the booth are stored in appropriate conditions to ensure order and compliance with ecological standards.",
                        imageOnLeft: false,
                        alignRight: true,
                      ),
                      _buildArrowWithNumber(4),
                      _buildAlternatingSection(
                        title: "DEMONTAŻ",
                        imagePath: 'assets/Team/pigi.png',
                        description: isPolish
                            ? "Po prezentacji stoiska na wydarzeniu targowym, zespół przystępuje do demontażu, w ramach którego pracownicy zostawiają po stoisku czystość."
                            : "After presenting the booth at the trade event, the team begins disassembly, during which the workers leave the booth area clean.",
                        imageOnLeft: true,
                        alignRight: false,
                      ),
                      _buildArrowWithNumber(5),
                      _buildAlternatingSection(
                        title: "UŚMIECH KLIENTA",
                        imagePath: 'assets/Team/pigi.png',
                        description: isPolish
                            ? "Na końcowym etapie możemy liczyć na ciepłe słowa uznania oraz uśmiech klienta, widząc efekty naszej ciężkiej pracy. To dla nas najcenniejsza nagroda - świadomość, że nasza staranność i profesjonalizm zostały docenione."
                            : "At the final stage, we can count on warm words of appreciation and the client's smile, seeing the results of our hard work. This is the most valuable reward for us - knowing that our diligence and professionalism have been recognized.",
                        imageOnLeft: false,
                        alignRight: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArrowWithNumber(int number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.arrow_downward,
          size: 50,
          color: const Color.fromARGB(255, 194, 181, 0),
        ),
        const SizedBox(width: 10),
        Text(
          '$number',
          style: GoogleFonts.michroma(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 194, 181, 0),
          ),
        ),
      ],
    );
  }

  Widget _buildAlternatingSection({
    required String title,
    required String imagePath,
    required String description,
    required bool imageOnLeft,
    required bool alignRight,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 350.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageOnLeft
            ? [
                _buildImage(imagePath),
                const SizedBox(width: 40),
                Expanded(
                    child: _buildTextSection(title, description, alignRight)),
              ]
            : [
                Expanded(
                    child: _buildTextSection(title, description, alignRight)),
                const SizedBox(width: 40),
                _buildImage(imagePath),
              ],
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    return Container(
      width: 400,
      height: 400,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(134, 194, 181, 0),
          width: 3,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 97, 90, 0).withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTextSection(String title, String description, bool alignRight) {
    return Column(
      crossAxisAlignment:
          alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.michroma(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 194, 181, 0),
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: GoogleFonts.michroma(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(1, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
