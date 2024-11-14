import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamDialog extends StatelessWidget {
  final bool isPolish;
  final Gradient borderGradient;

  const TeamDialog({
    Key? key,
    required this.isPolish,
    required this.borderGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: borderGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(17),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    isPolish ? "Nasz Zespół" : "Our Team",
                    style: GoogleFonts.openSans(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Jakub Bagrowski
                  _buildTeamMember(
                    context: context,
                    name: "Jakub Bagrowski",
                    position:
                        isPolish ? "Szef wszystkich szefów" : "Team Leader",
                    description: isPolish
                        ? "Jakub jest założycielem i liderem naszej firmy, z wieloletnim doświadczeniem w branży i wizją, która napędza nasz zespół do realizacji ambitnych projektów."
                        : "Jakub is the founder and CEO of our company, with extensive experience in the industry and a vision that drives our team to achieve ambitious projects.",

                    imagePath:
                        'assets/team/Jakub Bagrowski.png', // Ścieżka do zdjęcia
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 40),

                  // Magdalena Kostrzewska
                  _buildTeamMember(
                    context: context,
                    name: "Magdalena Kostrzewska",
                    position:
                        isPolish ? "Kierownik Projektu" : "Project Manager",
                    description: isPolish
                        ? "Magda jest doświadczonym specjalistą z wieloletnim stażem w branży zarządzania projektami, odpowiedzialnym za nadzór nad kluczowymi realizacjami."
                        : "Magda is an experienced project management specialist responsible for overseeing key projects with years of industry experience.",
                    imagePath:
                        'assets/Team/Magdalena Kostrzewska.png', // Ścieżka do zdjęcia
                    color: Colors.redAccent,
                  ),
                  const SizedBox(height: 30),

                  // Przycisk zamknięcia
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        isPolish ? "Zamknij" : "Close",
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTeamMember({
    required BuildContext context,
    required String name,
    required String position,
    required String description,
    required String imagePath, // Nowy parametr dla ścieżki zdjęcia
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Wyświetlanie zdjęcia pracownika
        ClipRRect(
          borderRadius: BorderRadius.circular(50), // Zaokrąglone zdjęcie
          child: Image.asset(
            imagePath,
            width: 100, // Rozmiar zdjęcia
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),

        // Imię i nazwisko
        Text(
          name,
          style: GoogleFonts.openSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 5),

        // Stanowisko
        Text(
          position,
          style: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 10),

        // Opis
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
