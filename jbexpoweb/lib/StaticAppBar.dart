import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final bool isSmallScreen = screenWidth < 800;

    return AppBar(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      elevation: 7,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.asset(
              'assets/JBExpoLogo.png',
              height: 85.0,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      actions: [
        if (!isSmallScreen) ...[
          _buildNavButton(
            context,
            0,
            isPolish ? "Strona główna" : "Home",
            Icons.home,
            currentIndex == 0,
          ),
          _buildNavButton(
            context,
            1,
            isPolish ? "Jak działamy" : "How We Work",
            Icons.work_outline,
            currentIndex == 1,
          ),
          _buildNavButton(
            context,
            2,
            isPolish ? "Portfolio" : "Portfolio",
            Icons.photo_album_outlined,
            currentIndex == 2,
          ),
          _buildIconWithTextButton(
            context,
            Icons.contact_mail,
            isPolish ? "Kontakt" : "Contact",
            onTap: () {
              Navigator.pushNamed(context, '/contact');
            },
          ),
          _buildIconWithTextButton(
            context,
            Icons.public,
            isPolish ? "Strona Google" : "Google Page",
            onTap: () async {
              const url = 'https://g.co/kgs/9fbbLNN';
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
          ),
          _buildIconWithTextButton(
            context,
            Icons.facebook,
            "Facebook",
            onTap: () async {
              const url =
                  'https://www.facebook.com/profile.php?id=100088078372925';
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
          ),
          Row(
            children: [
              SvgPicture.asset(
                'packages/country_icons/icons/flags/svg/gb.svg',
                width: 20,
                height: 20,
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
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ] else ...[
          PopupMenuButton<int>(
            icon: const Icon(Icons.menu, color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.black.withOpacity(0.9),
            itemBuilder: (context) => [
              _buildMenuItem(0, isPolish ? "Strona główna" : "Home"),
              _buildMenuItem(1, isPolish ? "Jak działamy" : "How We Work"),
              _buildMenuItem(2, isPolish ? "Portfolio" : "Portfolio"),
              const PopupMenuDivider(),
              PopupMenuItem<int>(
                value: -1,
                child: Row(
                  children: [
                    const Icon(Icons.contact_mail, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      isPolish ? "Kontakt" : "Contact",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: -2,
                child: Row(
                  children: [
                    const Icon(Icons.public, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      isPolish ? "Strona Google" : "Google Page",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: -3,
                child: Row(
                  children: [
                    const Icon(Icons.facebook, color: Colors.blueAccent),
                    const SizedBox(width: 8),
                    const Text(
                      "Facebook",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (value) async {
              if (value == 0 || value == 1 || value == 2) {
                onNavigate(value);
              } else if (value == -1) {
                Navigator.pushNamed(context, '/contact');
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
              }
            },
          ),
        ],
      ],
    );
  }

  Widget _buildNavButton(
    BuildContext context,
    int index,
    String label,
    IconData icon,
    bool isHighlighted,
  ) {
    return TextButton(
      onPressed: () {
        if (currentIndex != index) {
          onNavigate(index);
        }
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: isHighlighted
                ? const Color.fromARGB(255, 161, 151, 0)
                : Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: isHighlighted
                  ? const Color.fromARGB(255, 161, 151, 0)
                  : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconWithTextButton(
      BuildContext context, IconData icon, String label,
      {required VoidCallback onTap}) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<int> _buildMenuItem(int value, String label) {
    return PopupMenuItem<int>(
      value: value,
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
