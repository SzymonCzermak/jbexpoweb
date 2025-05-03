import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color.fromARGB(255, 17, 17, 17), // Tło stopki
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isSmallScreen = constraints.maxWidth < 600;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!isSmallScreen)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Lewa kolumna - zawartość stopki
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildFooterContent(),
                      ),
                    ),
                    // Prawa kolumna - ikony mediów społecznościowych
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: _buildSocialMediaIcons(),
                      ),
                    ),
                  ],
                ),
              if (isSmallScreen)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ..._buildFooterContent(),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: _buildSocialMediaIcons(),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              // Informacja o projekcie i prawa zastrzeżone
              Column(
                children: [
                  const Text(
                    'Design oraz pełna realizacja strony: Szymon Czermak',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '© 2025 JB Expo. Wszelkie prawa zastrzeżone.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  /// Tworzenie zawartości stopki
  List<Widget> _buildFooterContent() {
    return [
      // Nazwa firmy
      Image.asset(
        'assets/JBExpoLogo.png',
        height: 80.0,
        fit: BoxFit.contain,
      ),
      const SizedBox(height: 10),
      // Adres
      Row(
        children: [
          const Icon(Icons.location_on,
              color: Color.fromARGB(255, 255, 217, 0), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Dworcowa 1, 62-420 Strzałkowo, Polska',
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
          ),
        ],
      ),
      const SizedBox(height: 5),
      // Numer telefonu
      Row(
        children: [
          const Icon(Icons.phone,
              color: Color.fromARGB(255, 0, 255, 13), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '+48 515 000 868',
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
          ),
        ],
      ),
      const SizedBox(height: 5),
      // E-mail
      Row(
        children: [
          const Icon(Icons.email,
              color: Color.fromARGB(255, 0, 132, 255), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'jbexpo@jbexpo.pl',
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
          ),
        ],
      ),
    ];
  }

  /// Tworzenie ikon mediów społecznościowych
  List<Widget> _buildSocialMediaIcons() {
    return [
      // Pierwszy rząd: Instagram i Facebook
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(
                'Instagram',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              const SizedBox(width: 8),
              _buildSocialIcon(
                icon: FontAwesomeIcons.instagram,
                color: Colors.pink,
                url: 'https://www.instagram.com',
              ),
            ],
          ),
          const SizedBox(width: 20), // Odstęp między Instagramem a Facebookiem
          Row(
            children: [
              Text(
                'Facebook',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              const SizedBox(width: 8),
              _buildSocialIcon(
                icon: FontAwesomeIcons.facebook,
                color: Colors.blue,
                url: 'https://www.facebook.com/profile.php?id=100088078372925',
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 10), // Odstęp między rzędami
      // Drugi rząd: Twitter i Google
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(
                'WhatsApp',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              const SizedBox(width: 8),
              _buildSocialIcon(
                icon: FontAwesomeIcons.whatsapp,
                color: const Color.fromARGB(255, 37, 211, 102),
                url: 'https://wa.me/515000868',
              ),
            ],
          ),

          const SizedBox(width: 34), // Odstęp między Twitterem a Google
          Row(
            children: [
              Text(
                'Google',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              const SizedBox(width: 8),
              _buildSocialIcon(
                icon: FontAwesomeIcons.google,
                color: const Color.fromARGB(255, 251, 255, 0),
                url: 'https://g.co/kgs/9fbbLNN',
              ),
            ],
          ),
        ],
      ),
    ];
  }

  /// Tworzenie pojedynczej ikony z możliwością kliknięcia
  Widget _buildSocialIcon({
    required IconData icon,
    required Color color,
    required String url,
  }) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          debugPrint('Nie można otworzyć $url');
        }
      },
      child: CircleAvatar(
        radius: 18,
        backgroundColor: color.withOpacity(0.1),
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }
}
