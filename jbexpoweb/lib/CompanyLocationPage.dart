import 'dart:html'; // Dodano do obsługi elementu iframe
import 'dart:ui' as ui; // Potrzebne do rejestracji widoku platformy

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dyn_mouse_scroll/dyn_mouse_scroll.dart';
import 'package:jbexpoweb/FooterWidget.dart';

class CompanyLocationWebPage extends StatelessWidget {
  final bool isPolish;

  const CompanyLocationWebPage({Key? key, required this.isPolish})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String htmlId = "google-maps-iframe";

    // Rejestracja iframe jako platformowego widoku HTML
    ui.platformViewRegistry.registerViewFactory(
      htmlId,
      (int viewId) => IFrameElement()
        ..src =
            "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3973.3095481537557!2d17.807089213117337!3d52.311466151530006!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x4704c77f4ae3b8d9%3A0x514707cc8aa79408!2sJB%20EXPO%20Plus%20z.o.o!5e1!3m2!1spl!2spl!4v1736031390825!5m2!1spl!2spl"
        ..style.border = "none", // Usunięcie ramki z iframe
    );

    return Scaffold(
      body: DynMouseScroll(
        builder: (context, controller, physics) => SingleChildScrollView(
          controller: controller,
          physics: physics,
          child: Stack(
            children: [
              // Tło - obraz z zasobów
              Positioned.fill(
                child: Image.asset(
                  'assets/Background3.png',
                  fit: BoxFit.cover,
                ),
              ),
              // Zawartość strony
              Column(
                children: [
                  const SizedBox(height: 60),

                  // Tytuł strony
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double titleFontSize = constraints.maxWidth > 800
                          ? 80
                          : 28; // Rozmiar dla dużych i małych ekranów
                      double subtitleFontSize = constraints.maxWidth > 800
                          ? 24
                          : 16; // Mniejszy tekst dla opisu

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Główny tytuł
                          Text(
                            isPolish ? "Nasza Lokalizacja" : "Our Location",
                            style: GoogleFonts.michroma(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 194, 181, 0),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),

                          // Podtytuł
                          Text(
                            isPolish
                                ? "Punkt wyjścia dla Twojego targowego sukcesu"
                                : "The starting point for your trade fair success",
                            style: GoogleFonts.michroma(
                              fontSize: subtitleFontSize,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Divider(
                      color: Color.fromARGB(255, 255, 255, 255), // Kolor kreski
                      thickness: 2, // Grubość kreski
                      indent: 50, // Wcięcie od lewej
                      endIndent: 50, // Wcięcie od prawej
                    ),
                  ),

                  // Mapa
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(
                          maxWidth: 1200), // Ograniczenie szerokości
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: const AspectRatio(
                          aspectRatio: 16 / 9,
                          child: HtmlElementView(viewType: htmlId),
                        ),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Divider(
                      color: Color.fromARGB(255, 255, 255, 255), // Kolor kreski
                      thickness: 2, // Grubość kreski
                      indent: 50, // Wcięcie od lewej
                      endIndent: 50, // Wcięcie od prawej
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Stopka
                  const FooterWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
