import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;

    // Ustal maksymalną szerokość dialogu
    final dialogWidth = screenWidth > 700 ? 700.0 : screenWidth * 0.9;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      backgroundColor: Colors.transparent,
      child: Container(
        width: dialogWidth,
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Tytuł dialogu
                  Text(
                    isPolish ? "Nasz Zespół" : "Our Team",
                    style: GoogleFonts.openSans(
                      fontSize: screenWidth > 400 ? 28 : 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Siatka z pracownikami
                  Column(
                    children: [
                      _buildTeamRow(context, screenWidth, [
                        _buildTeamMember(
                          context: context,
                          name: "Jakub Bagrowski",
                          position: isPolish
                              ? "Kierownik Zespołu, Szef"
                              : "Team Leader, Chief Executive",
                          phone: "+48 123 456 789",
                          email: "jbexpo@jbexpo.pl",
                          color: Colors.blueAccent,
                          imagePath: 'assets/team/Jakub Bagrowski.png',
                        ),
                        _buildTeamMember(
                          context: context,
                          name: "Joanna Kasprzyk",
                          position: isPolish
                              ? "Kierownik Zarządzania"
                              : "Management Supervisor",
                          phone: "+48 786 669 657",
                          email: "jbexpoplus@gmail.com",
                          color: Colors.redAccent,
                          imagePath: 'assets/team/pigi.png',
                        ),
                      ]),
                      const SizedBox(height: 20),
                      Container(height: 1, color: Colors.white54),
                      const SizedBox(height: 20),
                      _buildTeamRow(context, screenWidth, [
                        _buildTeamMember(
                          context: context,
                          name: "Magdalena Czermak",
                          position: isPolish
                              ? "Kierownik Logistyki"
                              : "Logistics Manager",
                          phone: "+48 555 666 777",
                          email: "jbexpoplus.biuro@gmail.com ",
                          color: Colors.blueAccent,
                          imagePath: 'assets/team/Magdalena Kostrzewska.png',
                        ),
                        _buildTeamMember(
                          context: context,
                          name: "Zuzanna Sieradzka",
                          position: isPolish ? "Asystent" : "Assistant",
                          phone: "+48 515 367 526",
                          email: "jbexpoplus.office@gmail.com",
                          color: Colors.redAccent,
                          imagePath: 'assets/team/pigi.png',
                        ),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Przycisk zamknięcia
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
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

  Widget _buildTeamRow(
      BuildContext context, double screenWidth, List<Widget> members) {
    if (screenWidth > 600) {
      return Row(
        children: members
            .map((member) => Expanded(child: member))
            .toList()
            .expand((widget) => [widget, _buildDivider()])
            .toList()
          ..removeLast(),
      );
    } else {
      return Column(
        children: members
            .map((member) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: member,
                ))
            .toList(),
      );
    }
  }

  Widget _buildDivider() {
    return Container(width: 1, height: 100, color: Colors.white54);
  }

  Widget _buildTeamMember({
    required BuildContext context,
    required String name,
    required String position,
    required String phone,
    required String email,
    required Color color,
    required String imagePath,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Zdjęcie z obsługą błędów
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            imagePath,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                'https://via.placeholder.com/70',
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          position,
          style: GoogleFonts.openSans(
            fontSize: 14,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),

        // Telefon
        _buildContactItem(
          context: context,
          icon: Icons.phone,
          text: phone.isNotEmpty ? phone : "Brak numeru",
          color: Colors.green,
        ),

        // Email
        _buildContactItem(
          context: context,
          icon: Icons.email,
          text: email.isNotEmpty ? email : "Brak emaila",
          color: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required BuildContext context,
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
