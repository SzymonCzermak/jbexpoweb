import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class EndSection extends StatelessWidget {
  final bool isPolish;

  const EndSection({Key? key, required this.isPolish}) : super(key: key);

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isPolish
              ? "Skopiowano do schowka: $text"
              : "Copied to clipboard: $text",
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url, BuildContext context) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                isPolish ? "Nie można otworzyć linku." : "Cannot open link.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;
    final scaleFactor = screenHeight < 700 ? screenHeight / 700 : 1.0;

    final buttonWidth = isMobile
        ? screenWidth * 0.6
        : screenWidth * 0.2 * scaleFactor.clamp(0.7, 1.0);
    final buttonHeight = 50.0 * scaleFactor.clamp(0.6, 1.0);
    final iconSize = isMobile ? 20.0 * scaleFactor : 24.0 * scaleFactor;
    final fontSize = isMobile ? 10.0 * scaleFactor : 14.0 * scaleFactor;
    final textSize = isMobile ? 16.0 * scaleFactor : 20.0 * scaleFactor;

    return Container(
      width: double.infinity,
      height: screenHeight,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Background3.png'),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.0 : screenWidth * 0.1,
        vertical: 32.0 * scaleFactor,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isPolish ? "Skontaktuj się z nami!" : "Get in touch with us!",
              textAlign: TextAlign.center,
              style: GoogleFonts.michroma(
                fontSize: textSize,
                fontWeight: FontWeight.w400,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12 * scaleFactor,
              runSpacing: 12 * scaleFactor,
              children: [
                _buildActionButton(
                  context: context,
                  icon: Icons.phone,
                  label: isPolish ? "Zadzwoń" : "Call",
                  onTap: () => _launchUrl("tel:+48515000868", context),
                  width: buttonWidth,
                  height: buttonHeight,
                  fontSize: fontSize,
                  iconSize: iconSize,
                ),
                _buildActionButton(
                  context: context,
                  icon: Icons.email,
                  label: isPolish ? "Kopiuj Email" : "Copy Email",
                  onTap: () => _copyToClipboard(context, "jbexpo@jbexpo.pl"),
                  width: buttonWidth,
                  height: buttonHeight,
                  fontSize: fontSize,
                  iconSize: iconSize,
                ),
                _buildActionButton(
                  context: context,
                  icon: Icons.map,
                  label: "Google Maps",
                  onTap: () => _launchUrl(
                    "https://www.google.com/maps/search/?api=1&query=Dworcowa+1,+62-420+Strzałkowo,+Polska",
                    context,
                  ),
                  width: buttonWidth,
                  height: buttonHeight,
                  fontSize: fontSize,
                  iconSize: iconSize,
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSocialIcons(context),
            const SizedBox(height: 16),
            Text(
              "Design oraz pełna realizacja strony:\nSzymon Czermak",
              textAlign: TextAlign.center,
              style: GoogleFonts.michroma(
                fontSize: 12 * scaleFactor,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "© 2025 JB Expo. Wszelkie prawa zastrzeżone.",
              textAlign: TextAlign.center,
              style: GoogleFonts.michroma(
                fontSize: 14 * scaleFactor,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
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
              color: Colors.white,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(96, 94, 94, 94),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Color.fromARGB(255, 194, 181, 0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcons(BuildContext context) {
    const double iconSize = 28;
    const double spacing = 16;

    final List<Map<String, dynamic>> socials = [
      {
        'icon': FontAwesomeIcons.instagram,
        'color': Colors.pink,
        'url': 'https://www.instagram.com',
      },
      {
        'icon': FontAwesomeIcons.facebook,
        'color': Colors.blue,
        'url': 'https://www.facebook.com/profile.php?id=100088078372925',
      },
      {
        'icon': FontAwesomeIcons.whatsapp,
        'color': Color(0xFF25D366),
        'url': 'https://wa.me/515000868',
      },
      {
        'icon': FontAwesomeIcons.google,
        'color': Colors.amber,
        'url': 'https://g.co/kgs/9fbbLNN',
      },
      {
        'icon': FontAwesomeIcons.weixin,
        'color': Colors.green,
        'url': 'https://www.wechat.com/en/',
      },
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: spacing,
      children: socials.map((social) {
        return GestureDetector(
          onTap: () => _launchUrl(social['url'], context),
          child: CircleAvatar(
            backgroundColor: social['color'].withOpacity(0.2),
            radius: iconSize / 1.6,
            child: Icon(
              social['icon'],
              color: social['color'],
              size: iconSize,
            ),
          ),
        );
      }).toList(),
    );
  }
}
