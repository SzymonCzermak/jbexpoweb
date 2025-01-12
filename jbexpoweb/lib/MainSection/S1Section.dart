import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class S1Section extends StatelessWidget {
  final bool isPolish;

  const S1Section({Key? key, required this.isPolish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 16.0 : screenWidth * 0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isPolish ? 'Nasze Usługi' : 'Our Services',
              textAlign: TextAlign.center,
              style: GoogleFonts.michroma(
                fontSize: isSmallScreen ? 24.0 : 48.0,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 194, 181, 0),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              isPolish
                  ? 'Oferujemy szeroki zakres usług, aby spełnić wszystkie Twoje potrzeby.'
                  : 'We offer a wide range of services to meet all your needs.',
              textAlign: TextAlign.center,
              style: GoogleFonts.michroma(
                fontSize: isSmallScreen ? 12.0 : 16.0,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const SizedBox(height: 40),
            _buildServiceItem(
              context,
              isPolish ? 'Produkcja' : 'Production',
              isPolish
                  ? 'Dzięki właśnej produkcji, nasza firma zrealizuje stoiska targowe o każdej wielkości - zarówno małe jak i duże.'
                  : 'Thanks to our own production, our company can create trade booths of any size - both small and large.',
              'assets/jbexpo/Produkcja.png', // Change to the correct image path
              isImageLeft: true,
            ),
            const SizedBox(height: 20),
            _buildServiceItem(
              context,
              isPolish ? 'Profesjonalny sprzęt' : 'Logistics',
              isPolish ? '' : 'Professional Installers',
              'assets/jbexpo/Sprzet.png', // Zmień na właściwą ścieżkę do obrazu
              isImageLeft: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(
      BuildContext context, String title, String subtitle, String imagePath,
      {required bool isImageLeft}) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isImageLeft) ...[
              Expanded(
                flex: 1,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: isSmallScreen ? 100 : 200,
                  height: isSmallScreen ? 100 : 200,
                ),
              ),
              const SizedBox(width: 20),
            ],
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.michroma(
                      fontSize: isSmallScreen ? 18.0 : 24.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 194, 181, 0),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.michroma(
                      fontSize: isSmallScreen ? 10.0 : 14.0,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
            if (!isImageLeft) ...[
              const SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: isSmallScreen ? 100 : 200,
                  height: isSmallScreen ? 100 : 200,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
