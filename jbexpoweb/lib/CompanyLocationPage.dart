import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jbexpoweb/FooterWidget.dart';
import 'package:jbexpoweb/loading_widget.dart';

class CompanyLocationWebPage extends StatefulWidget {
  final bool isPolish;

  const CompanyLocationWebPage({Key? key, required this.isPolish})
      : super(key: key);

  @override
  State<CompanyLocationWebPage> createState() => _CompanyLocationWebPageState();
}

class _CompanyLocationWebPageState extends State<CompanyLocationWebPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    const String htmlId = "google-maps-iframe";

    ui.platformViewRegistry.registerViewFactory(
      htmlId,
      (int viewId) => IFrameElement()
        ..src =
            "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3973.3095481537557!2d17.807089213117337!3d52.311466151530006!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x4704c77f4ae3b8d9%3A0x514707cc8aa79408!2sJB%20EXPO%20Plus%20z.o.o!5e1!3m2!1spl!2spl!4v1736031390825!5m2!1spl!2spl"
        ..style.border = "none",
    );

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isLoading = false;
      });
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isLoading
          ? const AnimatedLoadingWidget()
          : Listener(
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
                                radius: 1.2,
                                colors: [
                                  Color.fromARGB(
                                      100, 255, 0, 0), // Czerwony rozbłysk
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
                                radius: 4,
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
                        LayoutBuilder(
                          builder: (context, constraints) {
                            double titleFontSize =
                                constraints.maxWidth > 800 ? 80 : 28;
                            double subtitleFontSize =
                                constraints.maxWidth > 800 ? 24 : 16;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.isPolish
                                      ? "Nasza Lokalizacja"
                                      : "Our Location",
                                  style: GoogleFonts.michroma(
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromARGB(255, 194, 181, 0),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget.isPolish
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
                            color: Colors.white,
                            thickness: 2,
                            indent: 50,
                            endIndent: 50,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 1200),
                            padding: const EdgeInsets.all(16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: const AspectRatio(
                                aspectRatio: 16 / 9,
                                child: HtmlElementView(
                                    viewType: 'google-maps-iframe'),
                              ),
                            ),
                          ),
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
}
