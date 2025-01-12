import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeSection extends StatefulWidget {
  final bool isPolish;
  final Color color;

  const WelcomeSection({
    Key? key,
    required this.isPolish,
    this.color = const Color.fromARGB(255, 216, 216, 216),
  }) : super(key: key);

  @override
  _WelcomeSectionState createState() => _WelcomeSectionState();
}

class _WelcomeSectionState extends State<WelcomeSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimationHeader;
  late Animation<Offset> _slideAnimationHeader;
  late Animation<double> _opacityAnimationText;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _opacityAnimationHeader = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _slideAnimationHeader =
        Tween<Offset>(begin: const Offset(0, -1.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _opacityAnimationText = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _widthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.80, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;

    // Dynamiczne marginesy
    final double horizontalPadding = isSmallScreen ? 16.0 : screenWidth * 0.1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _slideAnimationHeader,
              child: FadeTransition(
                opacity: _opacityAnimationHeader,
                child: Text(
                  widget.isPolish ? 'Miło Cię widzieć!' : 'Great to see you!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.michroma(
                    fontSize: isSmallScreen ? 36.0 : 80.0,
                    fontWeight: FontWeight.bold,
                    color: widget.color,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            FadeTransition(
              opacity: _opacityAnimationText,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.isPolish
                          ? 'Jesteśmy ekspertami w budowie stoisk targowych. Nasza firma specjalizuje się w produkcji, montażu i demontażu stoisk, które wyróżniają się '
                          : 'We are experts in building trade booths. Our company specializes in the production, assembly, and disassembly of booths that stand out for their ',
                      style: GoogleFonts.michroma(
                        fontSize: isSmallScreen ? 14.0 : 18.0,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: widget.color,
                      ),
                    ),
                    TextSpan(
                      text: widget.isPolish ? 'estetyką' : 'aesthetics',
                      style: GoogleFonts.michroma(
                        fontSize: isSmallScreen ? 14.0 : 18.0,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: const Color.fromARGB(255, 194, 181, 0),
                      ),
                    ),
                    TextSpan(
                      text: widget.isPolish ? ' i ' : ' and ',
                      style: GoogleFonts.michroma(
                        fontSize: isSmallScreen ? 14.0 : 18.0,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: widget.color,
                      ),
                    ),
                    TextSpan(
                      text: widget.isPolish
                          ? 'innowacyjnymi rozwiązaniami'
                          : 'innovative solutions',
                      style: GoogleFonts.michroma(
                        fontSize: isSmallScreen ? 14.0 : 18.0,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: const Color.fromARGB(255, 194, 181, 0),
                      ),
                    ),
                    TextSpan(
                      text: widget.isPolish
                          ? '. Pomagamy naszym klientom skutecznie zaprezentować swoją markę i przyciągnąć uwagę odwiedzających. Dzięki doświadczeniu i dbałości o detale, nasze realizacje stają się kluczem do sukcesu!'
                          : '. We help our clients effectively present their brand and attract visitors. Thanks to our experience and attention to detail, our projects become the key to success!',
                      style: GoogleFonts.michroma(
                        fontSize: isSmallScreen ? 14.0 : 18.0,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: widget.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _widthAnimation,
              builder: (context, child) {
                return Container(
                  width: _widthAnimation.value * screenWidth * 0.8,
                  height: 2,
                  color: const Color.fromARGB(255, 255, 255, 255),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
