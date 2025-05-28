import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _visibleList = List.filled(4, false);
    _triggerAnimations();

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
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        _visibleList[i] = true;
      });
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> teamMembers = [
      {
        "name": "Jakub Bagrowski",
        "position": widget.isPolish ? "Kierownik Zespołu" : "Team Leader",
        "phone": "+48 515 000 868",
        "email": "jbexpo@jbexpo.pl",
        "image": "assets/JakubBagrowski.png",
      },
      {
        "name": "Joanna Kasprzyk",
        "position":
            widget.isPolish ? "Kierownik Zarządzania" : "Management Supervisor",
        "phone": "+48 786 669 657",
        "email": "jbexpoplus@gmail.com",
        "image": "assets/LogoKostki.png",
      },
      {
        "name": "Magdalena Kostrzewska",
        "position":
            widget.isPolish ? "Kierownik Logistyki" : "Logistics Manager",
        "phone": "+48 572 634 224",
        "email": "jbexpoplus.biuro@gmail.com",
        "image": "assets/MagdalenaKostrzewska.png",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Listener(
        onPointerSignal: (pointerSignal) {
          if (pointerSignal is PointerScrollEvent) {
            _handleScroll(pointerSignal);
          }
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Stack(
            children: [
              Positioned.fill(
                child: Stack(
                  children: [
                    Container(color: Colors.black), // Czarne tło bazowe
                    Container(
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.topLeft,
                          radius: 2,
                          colors: [
                            Color.fromARGB(100, 255, 0, 0), // Czerwony rozbłysk
                            Colors.transparent,
                          ],
                          stops: [0.0, 1.0],
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.bottomRight,
                          radius: 6,
                          colors: [
                            Color.fromARGB(
                                100, 0, 0, 255), // Niebieski rozbłysk
                            Colors.transparent,
                          ],
                          stops: [0.0, 1.0],
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/Background3.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
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
                      color: Colors.white,
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

  void _handleScroll(PointerScrollEvent pointerSignal) {
    final double delta = pointerSignal.scrollDelta.dy;
    bool isTouchpad = delta.abs() < 50;
    double offsetChange = delta * (isTouchpad ? 0.5 : 1.0);

    double newOffset = _scrollController.offset + offsetChange;
    newOffset = newOffset.clamp(
      _scrollController.position.minScrollExtent,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.jumpTo(newOffset);
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
            color: Colors.white,
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
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    MediaQuery.of(context).size.width < 600 ? 24.0 : 0.0,
              ),
              child: GestureDetector(
                onTap: () {
                  _shakeController.reset();
                  _shakeController.forward();
                },
                child: AnimatedBuilder(
                  animation: _shakeAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_shakeAnimation.value, 0),
                      child: AnimatedOpacity(
                        opacity: _visibleList[index] ? 1 : 0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        child: _buildTeamCard(member, context),
                      ),
                    );
                  },
                ),
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
    return Column(
      children: [
        Row(
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
        ),
        if (isPhone)
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: color.withOpacity(0.2),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => _launchPhone(text),
              icon: const Icon(Icons.call, size: 16, color: Colors.white),
              label: Text(
                widget.isPolish ? "Zadzwoń" : "Call",
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
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
