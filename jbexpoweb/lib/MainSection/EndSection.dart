import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jbexpoweb/FooterWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class EndSection extends StatefulWidget {
  final bool isPolish;

  const EndSection({Key? key, required this.isPolish}) : super(key: key);

  @override
  _EndSectionState createState() => _EndSectionState();
}

class _EndSectionState extends State<EndSection> with TickerProviderStateMixin {
  late AnimationController _textController;
  late AnimationController _footerController;
  late AnimationController _buttonsController;

  late Animation<Offset> _textOffsetAnimation;
  late Animation<Offset> _footerOffsetAnimation;
  late Animation<Offset> _buttonsOffsetAnimation;

  late Animation<double> _textOpacityAnimation;
  late Animation<double> _footerOpacityAnimation;
  late Animation<double> _buttonsOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _footerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _buttonsController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _textOffsetAnimation =
        Tween<Offset>(begin: Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );
    _footerOffsetAnimation =
        Tween<Offset>(begin: Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _footerController, curve: Curves.easeOut),
    );
    _buttonsOffsetAnimation =
        Tween<Offset>(begin: Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _buttonsController, curve: Curves.easeOut),
    );

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );
    _footerOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _footerController, curve: Curves.easeOut),
    );
    _buttonsOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _buttonsController, curve: Curves.easeOut),
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await _textController.forward();
    await _footerController.forward();
    await _buttonsController.forward();
  }

  @override
  void dispose() {
    _textController.dispose();
    _footerController.dispose();
    _buttonsController.dispose();
    super.dispose();
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.isPolish
              ? "Skopiowano do schowka: $text"
              : "Copied to clipboard: $text",
        ),
      ),
    );
  }

  Future<void> _launchPhone(BuildContext context) async {
    const String phoneNumber = "+48 515 000 868";
    final Uri phoneUri = Uri.parse("tel:$phoneNumber");

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      _copyToClipboard(context, phoneNumber);
    }
  }

  Future<void> _launchGoogleMaps(BuildContext context) async {
    const String mapsUrl =
        "https://www.google.com/maps/search/?api=1&query=Dworcowa+1,+62-420+Strzałkowo,+Polska";

    if (await canLaunchUrl(Uri.parse(mapsUrl))) {
      await launchUrl(Uri.parse(mapsUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isPolish
                ? "Nie można otworzyć Google Maps."
                : "Unable to open Google Maps.",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    final double buttonWidth =
        isMobile ? screenWidth * 0.25 : screenWidth * 0.15;
    final double buttonHeight = isMobile ? 50.0 : 60.0;
    final double iconSize = isMobile ? 20.0 : 24.0;
    final double fontSize = isMobile ? 10.0 : 14.0;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Background3.png'),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.0 : screenWidth * 0.1,
        vertical: 40.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlideTransition(
            position: _textOffsetAnimation,
            child: FadeTransition(
              opacity: _textOpacityAnimation,
              child: Text(
                widget.isPolish
                    ? "Zapraszamy do kontaktu, aby dowiedzieć się więcej o naszych usługach i projektach."
                    : "Feel free to contact us to learn more about our services and projects.",
                textAlign: TextAlign.center,
                style: GoogleFonts.michroma(
                  fontSize: isMobile ? 16 : 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[400],
                  height: 1.6,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          SlideTransition(
            position: _footerOffsetAnimation,
            child: FadeTransition(
              opacity: _footerOpacityAnimation,
              child: Container(
                width: isMobile ? screenWidth * 0.9 : screenWidth * 0.7,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 34, 34, 34).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                  border: Border.all(
                    color: const Color.fromARGB(255, 194, 181, 0),
                    width: 2.0,
                  ),
                ),
                child: const FooterWidget(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SlideTransition(
            position: _buttonsOffsetAnimation,
            child: FadeTransition(
              opacity: _buttonsOpacityAnimation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton(
                    context: context,
                    icon: Icons.phone,
                    label: widget.isPolish ? "Zadzwoń" : "Call",
                    onTap: () => _launchPhone(context),
                    width: buttonWidth,
                    height: buttonHeight,
                    fontSize: fontSize,
                    iconSize: iconSize,
                  ),
                  const SizedBox(width: 16),
                  _buildActionButton(
                    context: context,
                    icon: Icons.email,
                    label: widget.isPolish ? "Kopiuj Email" : "Copy Email",
                    onTap: () => _copyToClipboard(context, "jbexpo@jbexpo.pl"),
                    width: buttonWidth,
                    height: buttonHeight,
                    fontSize: fontSize,
                    iconSize: iconSize,
                  ),
                  const SizedBox(width: 16),
                  _buildActionButton(
                    context: context,
                    icon: Icons.map,
                    label: widget.isPolish ? "Google Maps" : "Google Maps",
                    onTap: () => _launchGoogleMaps(context),
                    width: buttonWidth,
                    height: buttonHeight,
                    fontSize: fontSize,
                    iconSize: iconSize,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required double width,
    required double height,
    required double fontSize,
    required double iconSize,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(
          icon,
          color: const Color.fromARGB(255, 194, 181, 0),
          size: iconSize,
        ),
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: GoogleFonts.michroma(
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(96, 94, 94, 94),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Color.fromARGB(255, 194, 181, 0),
              width: 1.0,
            ),
          ),
          elevation: 10,
          shadowColor: const Color.fromARGB(255, 121, 113, 0).withOpacity(0.4),
        ),
      ),
    );
  }
}
