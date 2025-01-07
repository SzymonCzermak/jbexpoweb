import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class ContactDialog extends StatelessWidget {
  final bool isPolish;
  final Gradient borderGradient;

  const ContactDialog({
    Key? key,
    required this.isPolish,
    required this.borderGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 215, 0), // Złoty początek gradientu
              Color.fromARGB(255, 218, 165, 32), // Złoty koniec gradientu
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(2), // Cieńsza ramka
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(18),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    isPolish ? "Kontakt" : "Contact",
                    style: GoogleFonts.openSans(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 60, 255, 0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildContactItem(
                    context: context,
                    icon: Icons.location_on,
                    text: isPolish
                        ? 'Strzałkowo 62-420 Dworcowa 1'
                        : 'Strzałkowo 62-420 Dworcowa 1',
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 15),
                  _buildContactItem(
                    context: context,
                    icon: Icons.phone,
                    text: isPolish ? '515 000 868' : '+48 515 000 868',
                    color: Colors.redAccent,
                  ),
                  const SizedBox(height: 15),
                  _buildContactItem(
                    context: context,
                    icon: Icons.email,
                    text: 'jbexpo@jbexpo.pl',
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 30),
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

  Widget _buildContactItem({
    required BuildContext context,
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(width: 10),
        Expanded(
          child: SelectableText(
            text,
            style: GoogleFonts.openSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.copy, color: Colors.white70),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: text));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text(isPolish ? "Skopiowano: $text" : "Copied: $text")),
            );
          },
        ),
      ],
    );
  }
}
