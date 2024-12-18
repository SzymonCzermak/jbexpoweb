import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jbexpoweb/contact_dialog.dart';
import 'package:jbexpoweb/team_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isPolish;
  final Function(bool) toggleLanguage;
  final PageController pageController; // Dodano PageController

  const ResponsiveAppBar({
    Key? key,
    required this.isPolish,
    required this.toggleLanguage,
    required this.pageController, // Dodano PageController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 800;

    return AppBar(
      backgroundColor: const Color.fromARGB(120, 0, 0, 0),
      elevation: 7,
      automaticallyImplyLeading: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/JBExpoLogo.png',
            height: isSmallScreen ? 88.0 : 88.0,
            fit: BoxFit.fill,
          ),
        ],
      ),
      actions: [
        if (!isSmallScreen) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ContactDialog(
                      isPolish: isPolish,
                      borderGradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 114, 0, 0),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    );
                  },
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.contact_mail,
                    color: const Color.fromARGB(255, 161, 151, 0),
                    size: isSmallScreen ? 14 : 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isPolish ? "Kontakt" : "Contact",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 14 : 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => TeamDialog(
                    isPolish: isPolish,
                    borderGradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 0, 54, 148),
                        Color.fromARGB(255, 114, 0, 0),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.people,
                    color: const Color.fromARGB(255, 161, 151, 0),
                    size: isSmallScreen ? 14 : 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isPolish ? "Poznaj nasz zespół!" : "Meet our Team",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 14 : 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextButton(
              onPressed: () {
                pageController.jumpToPage(3); // Indeks sekcji "Jak działamy"
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.work_outline,
                    color: const Color.fromARGB(255, 161, 151, 0),
                    size: isSmallScreen ? 14 : 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isPolish ? "Jak działamy" : "How We Work",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 14 : 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.public, color: Colors.white),
            onPressed: () {
              const url = 'https://g.co/kgs/9fbbLNN';
              launch(url);
            },
          ),
          IconButton(
            icon: const Icon(Icons.facebook, color: Colors.blueAccent),
            onPressed: () {
              const url =
                  'https://www.facebook.com/profile.php?id=100088078372925';
              launch(url);
            },
          ),
        ] else ...[
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.black.withOpacity(0.9),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "Kontakt",
                  child: ListTile(
                    leading: const Icon(Icons.contact_mail,
                        color: Color.fromARGB(255, 161, 151, 0)),
                    title: Text(
                      isPolish ? "Kontakt" : "Contact",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ContactDialog(
                            isPolish: isPolish,
                            borderGradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 255, 255, 255),
                                Color.fromARGB(255, 114, 0, 0),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                PopupMenuItem(
                  value: "Nasz Zespół",
                  child: ListTile(
                    leading: const Icon(Icons.people,
                        color: Color.fromARGB(255, 161, 151, 0)),
                    title: Text(
                      isPolish ? "Poznaj nasz zespół!" : "Meet our Team",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) => TeamDialog(
                          isPolish: isPolish,
                          borderGradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 0, 54, 148),
                              Color.fromARGB(255, 114, 0, 0),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                PopupMenuItem(
                  value: "JakDzialamy",
                  child: ListTile(
                    leading:
                        const Icon(Icons.work_outline, color: Colors.white),
                    title: Text(
                      isPolish ? "Jak działamy" : "How We Work",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      pageController.jumpToPage(2); // Indeks sekcji "Jak działamy"
                    },
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: "Strona",
                  child: ListTile(
                    leading: const Icon(Icons.public, color: Colors.white),
                    title: Text(
                      isPolish ? "Strona" : "Website",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onTap: () {
                      const url = 'https://g.co/kgs/9fbbLNN';
                      launch(url);
                    },
                  ),
                ),
                PopupMenuItem(
                  value: "Facebook",
                  child: ListTile(
                    leading:
                        const Icon(Icons.facebook, color: Colors.blueAccent),
                    title: Text(
                      "Facebook",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onTap: () {
                      const url =
                          'https://www.facebook.com/profile.php?id=100088078372925';
                      launch(url);
                    },
                  ),
                ),
              ];
            },
            offset: const Offset(0, 50),
            elevation: 8,
          ),
        ],
        SizedBox(
          width: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Transform.scale(
            scale: 1.0,
            child: Row(
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
