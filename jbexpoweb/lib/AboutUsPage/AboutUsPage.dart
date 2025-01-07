import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dyn_mouse_scroll/dyn_mouse_scroll.dart';
import 'package:jbexpoweb/FooterWidget.dart';

class AboutUsPage extends StatelessWidget {
  final bool isPolish;

  const AboutUsPage({Key? key, required this.isPolish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> teamMembers = [
      {
        "name": "Jakub Bagrowski",
        "position": isPolish
            ? "Kierownik Zespołu, Szef"
            : "Team Leader, Chief Executive",
        "phone": "+48 123 456 789",
        "email": "jbexpo@jbexpo.pl",
        "image": "assets/team/JakubBagrowski.png", // Poprawiona ścieżka
      },
      {
        "name": "Joanna Kasprzyk",
        "position":
            isPolish ? "Kierownik Zarządzania" : "Management Supervisor",
        "phone": "+48 786 669 657",
        "email": "jbexpoplus@gmail.com",
        "image": "assets/team/pigi.png", // Poprawiona ścieżka
      },
      {
        "name": "Magdalena Kostrzewska",
        "position": isPolish ? "Kierownik Logistyki" : "Logistics Manager",
        "phone": "+48 555 666 777",
        "email": "jbexpoplus.biuro@gmail.com",
        "image": "assets/team/MagdalenaKostrzewska.png", // Poprawiona ścieżka
      },
      {
        "name": "Zuzanna Sieradzka",
        "position": isPolish ? "Asystent" : "Assistant",
        "phone": "+48 515 367 526",
        "email": "jbexpoplus.office@gmail.com",
        "image": "assets/team/pigi.png", // Poprawiona ścieżka
      },
    ];

    return Scaffold(
      body: DynMouseScroll(
        builder: (context, controller, physics) => SingleChildScrollView(
          controller: controller,
          physics: physics,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/Background3.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        "Background image not found",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 60),
                  _buildHeader(context),
                  _buildTeamGrid(context, teamMembers),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Divider(
                      color: Color.fromARGB(255, 255, 255, 255),
                      thickness: 2,
                      indent: 50,
                      endIndent: 50,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const FooterWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          isPolish ? "Kilka słów o nas" : "A Few Words About Us",
          style: GoogleFonts.michroma(
            fontSize: MediaQuery.of(context).size.width > 800 ? 80 : 36,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 194, 181, 0),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          isPolish
              ? "Naszą pasją jest tworzenie przestrzeni, które odzwierciedlają Twoje wartości"
              : "Our passion is creating spaces that reflect your values",
          style: GoogleFonts.michroma(
            fontSize: MediaQuery.of(context).size.width > 800 ? 24 : 16,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Divider(
            color: Color.fromARGB(255, 255, 255, 255),
            thickness: 2,
            indent: 50,
            endIndent: 50,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamGrid(
      BuildContext context, List<Map<String, String>> teamMembers) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width < 600 ? 1 : 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 3 / 4,
          ),
          itemCount: teamMembers.length,
          itemBuilder: (context, index) {
            final member = teamMembers[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(158, 0, 0, 0),
                    Color.fromARGB(158, 0, 0, 0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: const Color.fromARGB(255, 194, 181, 0),
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(
                      member["image"]!,
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          'https://via.placeholder.com/180',
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    member["name"]!,
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    member["position"]!,
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  _buildContactItem(
                    context: context,
                    icon: Icons.phone,
                    text: member["phone"]!,
                    color: Colors.green,
                    isPhone: true,
                  ),
                  const SizedBox(height: 5),
                  _buildContactItem(
                    context: context,
                    icon: Icons.email,
                    text: member["email"]!,
                    color: Colors.blue,
                    isCopyable: true,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required BuildContext context,
    required IconData icon,
    required String text,
    required Color color,
    bool isCopyable = false,
    bool isPhone = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: isPhone ? () => _launchPhone(text) : null,
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.openSans(
              fontSize: 14,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (isCopyable) const SizedBox(width: 8),
        if (isCopyable)
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: text));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isPolish
                        ? "Skopiowano do schowka!"
                        : "Copied to clipboard!",
                  ),
                ),
              );
            },
            child: Icon(
              Icons.copy,
              color: Colors.grey[400],
              size: 18,
            ),
          ),
      ],
    );
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Could not launch $phoneNumber");
    }
  }
}
