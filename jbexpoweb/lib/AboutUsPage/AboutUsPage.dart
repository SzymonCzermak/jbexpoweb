import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dyn_mouse_scroll/dyn_mouse_scroll.dart';
import 'package:jbexpoweb/FooterWidget.dart';

class AboutUsPage extends StatefulWidget {
  final bool isPolish;

  const AboutUsPage({Key? key, required this.isPolish}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage>
    with SingleTickerProviderStateMixin {
  late List<bool> _visibleList;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    // Lista kontrolująca widoczność każdej kafelki
    _visibleList = List.filled(4, false);
    _triggerAnimations();

    // Inicjalizacja kontrolera animacji dla efektu trzęsienia
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10, end: -10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10, end: 5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 5, end: -5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -5, end: 0), weight: 1),
    ]).animate(_shakeController);
  }

  Future<void> _triggerAnimations() async {
    for (int i = 0; i < _visibleList.length; i++) {
      await Future.delayed(
          const Duration(milliseconds: 200)); // Opóźnienie między kafelkami
      setState(() {
        _visibleList[i] = true; // Ustaw widoczność dla kolejnych kafelków
      });
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> teamMembers = [
      {
        "name": "Jakub Bagrowski",
        "position": widget.isPolish
            ? "Kierownik Zespołu, Szef"
            : "Team Leader, Chief Executive",
        "phone": "+48 123 456 789",
        "email": "jbexpo@jbexpo.pl",
        "image": "assets/JakubBagrowski.png",
      },
      {
        "name": "Joanna Kasprzyk",
        "position":
            widget.isPolish ? "Kierownik Zarządzania" : "Management Supervisor",
        "phone": "+48 786 669 657",
        "email": "jbexpoplus@gmail.com",
        "image": "assets/pigi.png",
      },
      {
        "name": "Magdalena Kostrzewska",
        "position":
            widget.isPolish ? "Kierownik Logistyki" : "Logistics Manager",
        "phone": "+48 555 666 777",
        "email": "jbexpoplus.biuro@gmail.com",
        "image": "assets/MagdalenaKostrzewska.png",
      },
      {
        "name": "Zuzanna Sieradzka",
        "position": widget.isPolish ? "Asystent" : "Assistant",
        "phone": "+48 515 367 526",
        "email": "jbexpoplus.office@gmail.com",
        "image": "assets/pigi.png",
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
          widget.isPolish ? "Kilka słów o nas" : "A Few Words About Us",
          style: GoogleFonts.michroma(
            fontSize: MediaQuery.of(context).size.width > 800 ? 80 : 36,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 194, 181, 0),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          widget.isPolish
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
        constraints: const BoxConstraints(maxWidth: 625),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width < 600 ? 1 : 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 4 / 5,
          ),
          itemCount: teamMembers.length,
          itemBuilder: (context, index) {
            final member = teamMembers[index];
            return GestureDetector(
              onTap: () {
                _shakeController.reset();
                _shakeController.forward(); // Uruchomienie animacji trzęsienia
              },
              child: AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_shakeAnimation.value, 0), // Ruch poziomy
                    child: AnimatedOpacity(
                      opacity: _visibleList[index] ? 1 : 0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      child: _buildTeamCard(member, context),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTeamCard(Map<String, String> member, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
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
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              member["image"]!,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  'https://via.placeholder.com/150',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            member["name"]!,
            style: GoogleFonts.openSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            member["position"]!,
            style: GoogleFonts.openSans(
              fontSize: 14,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
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
                    widget.isPolish
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
