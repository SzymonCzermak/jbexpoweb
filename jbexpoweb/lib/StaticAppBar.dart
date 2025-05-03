import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbexpoweb/CompanyLocationPage.dart';
import 'package:jbexpoweb/contact_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class StaticAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isPolish;
  final Function(bool) toggleLanguage;
  final Function(int) onNavigate;
  final int currentIndex;

  const StaticAppBar({
    Key? key,
    required this.isPolish,
    required this.toggleLanguage,
    required this.onNavigate,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 1470;

    return AppBar(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      elevation: 7,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.asset(
              'assets/JBExpoLogo.png',
              height: 85.0,
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(),
        ],
      ),
      actions: [
        if (!isSmallScreen) ...[
          // Large screen layout
          const SizedBox(
            height: 20,
            child: VerticalDivider(
              color: Colors.white,
              thickness: 1,
              width: 5,
            ),
          ),
          _buildNavButton(
            context,
            0,
            isPolish ? "Strona główna" : "Home",
            Icons.home_outlined,
            Icons.home,
            currentIndex == 0,
          ),
          const SizedBox(
            height: 20,
            child: VerticalDivider(
              color: Colors.white,
              thickness: 1,
              width: 5,
            ),
          ),
          _buildNavButton(
            context,
            1,
            isPolish ? "Jak działamy" : "How We Work",
            Icons.work_outline,
            Icons.work,
            currentIndex == 1,
          ),
          const SizedBox(
            height: 20,
            child: VerticalDivider(
              color: Colors.white,
              thickness: 1,
              width: 5,
            ),
          ),
          _buildNavButton(
            context,
            2,
            isPolish ? "Portfolio" : "Portfolio",
            Icons.photo_album_outlined,
            Icons.photo_album,
            currentIndex == 2,
          ),
          const SizedBox(
            height: 20,
            child: VerticalDivider(
              color: Colors.white,
              thickness: 1,
              width: 5,
            ),
          ),
          _buildNavButton(
            context,
            3,
            isPolish ? "O nas" : "About Us",
            Icons.info_outline,
            Icons.info,
            currentIndex == 3,
          ),
          const SizedBox(
            height: 20,
            child: VerticalDivider(
              color: Colors.white,
              thickness: 1,
              width: 5,
            ),
          ),
          _buildNavButton(
            context,
            4, // Indeks strony lokalizacji w MainView
            isPolish ? "Lokalizacja" : "Location",
            Icons.location_on_outlined,
            Icons.location_on,
            currentIndex == 4,
          ),
          const SizedBox(
            height: 40,
            child: VerticalDivider(
              color: Colors.white,
              thickness: 1,
              width: 40,
            ),
          ),
          _buildIconWithTextButton(
            context,
            FontAwesomeIcons.envelope,
            isPolish ? "Kontakt" : "Contact",
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ContactDialog(
                    isPolish: isPolish,
                    borderGradient: const LinearGradient(
                      colors: [Colors.blueAccent, Colors.redAccent],
                    ),
                  );
                },
              );
            },
            color: const Color.fromARGB(
                255, 197, 72, 0), // Dodano zielony kolor dla ikony kontaktu
          ),

          _buildIconWithTextButton(
            context,
            FontAwesomeIcons.whatsapp,
            "WhatsApp",
            onTap: () async {
              const url = 'https://wa.me/515000868'; // <-- zmień na swój numer
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
            color: Colors.green,
          ),

          _buildIconWithTextButton(
            context,
            FontAwesomeIcons.instagram, // Ikona Instagrama z FontAwesome
            "Instagram",
            onTap: () async {
              const url = 'https://www.instagram.com';
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
            color: const Color.fromARGB(255, 253, 0, 219), // Kolor Instagrama
          ),

          _buildIconWithTextButton(
            context,
            FontAwesomeIcons.google,
            "Google",
            onTap: () async {
              const url = 'https://g.co/kgs/9fbbLNN';
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
            color: Colors.yellow, // Dodano żółty kolor dla ikony Google
          ),

          _buildIconWithTextButton(
            context,
            FontAwesomeIcons.facebook,
            "Facebook",
            onTap: () async {
              const url =
                  'https://www.facebook.com/profile.php?id=100088078372925';
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
            color: Colors.blue, // Dodano niebieski kolor dla ikony Facebook
          ),
          _buildIconWithTextButton(
            context,
            FontAwesomeIcons.weixin, // WeChat w FontAwesome nazywa się weixin
            "WeChat",
            onTap: () async {
              const url =
                  'https://weixin.qq.com/'; // <- domyślna strona WeChat lub Twój link, jeśli masz
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
            color: const Color.fromARGB(
                255, 0, 185, 0), // Zielony typowy dla WeChat
          ),
        ] else ...[
          // Small screen layout
          PopupMenuButton<int>(
            icon: const Icon(Icons.menu, color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.black.withOpacity(0.9),
            itemBuilder: (context) => [
              _buildMenuItem(0, isPolish ? "Strona główna" : "Home", Icons.home,
                  const Color.fromARGB(255, 194, 181, 0)),
              _buildMenuItem(1, isPolish ? "Jak działamy" : "How We Work",
                  Icons.work, const Color.fromARGB(255, 194, 181, 0)),
              _buildMenuItem(2, isPolish ? "Portfolio" : "Portfolio",
                  Icons.photo_album, const Color.fromARGB(255, 194, 181, 0)),
              _buildMenuItem(3, isPolish ? "O nas" : "About Us", Icons.info,
                  const Color.fromARGB(255, 194, 181, 0)),
              _buildMenuItem(4, isPolish ? "Lokalizacja" : "Location",
                  Icons.location_on, const Color.fromARGB(255, 194, 181, 0)),
              const PopupMenuDivider(),
              _buildMenuItem(
                -1,
                isPolish ? "Kontakt" : "Contact",
                FontAwesomeIcons.envelope,
                const Color.fromARGB(255, 197, 72, 0),
              ),
              _buildMenuItem(-5, "WhatsApp", FontAwesomeIcons.whatsapp,
                  Colors.green), // NOWY WhatsApp
              _buildMenuItem(
                  -2, "Google", FontAwesomeIcons.google, Colors.yellow),
              _buildMenuItem(
                  -3, "Facebook", FontAwesomeIcons.facebook, Colors.blue),
              _buildMenuItem(-4, "Instagram", FontAwesomeIcons.instagram,
                  const Color.fromARGB(255, 253, 0, 219)),
              _buildMenuItem(-7, "WeChat", FontAwesomeIcons.weixin,
                  const Color.fromARGB(255, 0, 185, 0)), // NOWY WeChat
            ],
            onSelected: (value) async {
              if (value >= 0) {
                onNavigate(value);
              } else if (value == -1) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ContactDialog(
                      isPolish: isPolish,
                      borderGradient: const LinearGradient(
                        colors: [Colors.blueAccent, Colors.redAccent],
                      ),
                    );
                  },
                );
              } else if (value == -5) {
                const url =
                    'https://wa.me/48600123456'; // <- Twój WhatsApp numer
                if (await canLaunch(url)) {
                  await launch(url);
                }
              } else if (value == -7) {
                const url = 'https://weixin.qq.com/'; // <- Twój link do WeChat
                if (await canLaunch(url)) {
                  await launch(url);
                }
              } else if (value == -2) {
                const url = 'https://g.co/kgs/9fbbLNN';
                if (await canLaunch(url)) {
                  await launch(url);
                }
              } else if (value == -3) {
                const url =
                    'https://www.facebook.com/profile.php?id=100088078372925';
                if (await canLaunch(url)) {
                  await launch(url);
                }
              } else if (value == -4) {
                const url =
                    'https://www.instagram.com/jbexpoplus?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==';
                if (await canLaunch(url)) {
                  await launch(url);
                }
              }
            },
          ),
        ],
        const SizedBox(
          height: 40,
          child: VerticalDivider(
            color: Colors.white,
            thickness: 1,
            width: 40,
          ),
        ),
        Row(
          children: [
            SvgPicture.asset(
              'packages/country_icons/icons/flags/svg/gb.svg',
              width: 15,
              height: 15,
            ),
            const SizedBox(width: 4),
            Switch(
              value: isPolish,
              onChanged: toggleLanguage,
              activeColor: Colors.white,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey,
            ),
            SvgPicture.asset(
              'packages/country_icons/icons/flags/svg/pl.svg',
              width: 15,
              height: 15,
            ),
            const SizedBox(width: 8),
          ],
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildNavButton(
    BuildContext context,
    int index,
    String label,
    IconData outlinedIcon,
    IconData filledIcon,
    bool isHighlighted,
  ) {
    final bool isSelected = currentIndex == index;

    return TextButton(
      onPressed: () {
        if (!isSelected) {
          onNavigate(index);
        }
      },
      child: Row(
        children: [
          Container(
            decoration: isSelected
                ? BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 161, 151, 0)
                            .withOpacity(0.4), // Cień w kolorze zaznaczenia
                        blurRadius: 25,
                        spreadRadius: 1,
                        offset: const Offset(10, 3), // Przesunięcie cienia
                      ),
                    ],
                  )
                : null,
            child: Icon(
              isSelected ? filledIcon : outlinedIcon,
              color: isSelected
                  ? const Color.fromARGB(255, 161, 151, 0)
                  : Colors.white,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: isSelected
                  ? const Color.fromARGB(255, 161, 151, 0)
                  : Colors.white,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconWithTextButton(
      BuildContext context, IconData icon, String label,
      {required VoidCallback onTap, required Color color}) {
    return TextButton(
      onPressed: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4), // Cień w kolorze ikony
                  blurRadius: 25,
                  spreadRadius: 1,
                  offset: const Offset(0, 7), // Przesunięcie cienia
                ),
              ],
            ),
            child: Icon(
              icon,
              color: color, // Dynamiczny kolor ikony
              size: 20,
            ),
          ),
          const SizedBox(height: 5), // Odstęp między ikoną a tekstem
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<int> _buildMenuItem(
      int value, String label, IconData icon, Color color) {
    return PopupMenuItem<int>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18), // Ikona z kolorami
          const SizedBox(width: 10), // Odstęp między ikoną a tekstem
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
