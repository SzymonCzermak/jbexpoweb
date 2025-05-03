import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class S2Section extends StatefulWidget {
  final bool isPolish;

  const S2Section({Key? key, required this.isPolish}) : super(key: key);

  @override
  _S2SectionState createState() => _S2SectionState();
}

class _S2SectionState extends State<S2Section> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  late AnimationController _textController;
  late Animation<Offset> _textOffsetAnimation;
  late Animation<double> _textOpacityAnimation;

  late AnimationController _dividerController;
  late Animation<double> _dividerWidthAnimation;

  late AnimationController _firstItemController;
  late Animation<Offset> _firstItemOffsetAnimation;
  late Animation<double> _firstItemOpacityAnimation;

  late AnimationController _secondItemController;
  late Animation<Offset> _secondItemOffsetAnimation;
  late Animation<double> _secondItemOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _widthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _textController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _textOffsetAnimation =
        Tween<Offset>(begin: Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeInOut,
      ),
    );

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: Curves.easeInOut,
      ),
    );

    _dividerController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _dividerWidthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _dividerController,
        curve: Curves.easeInOut,
      ),
    );

    _firstItemController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _firstItemOffsetAnimation =
        Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _firstItemController,
        curve: Curves.easeInOut,
      ),
    );

    _firstItemOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _firstItemController,
        curve: Curves.easeInOut,
      ),
    );

    _secondItemController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _secondItemOffsetAnimation =
        Tween<Offset>(begin: Offset(1, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _secondItemController,
        curve: Curves.easeInOut,
      ),
    );

    _secondItemOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _secondItemController,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
    _textController.forward().then((_) {
      _dividerController.forward().then((_) {
        _firstItemController.forward().then((_) {
          _secondItemController.forward();
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    _dividerController.dispose();
    _firstItemController.dispose();
    _secondItemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;
    final bool isLargeScreen = screenWidth > 1200;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 16.0 : screenWidth * 0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _textOffsetAnimation,
              child: FadeTransition(
                opacity: _textOpacityAnimation,
                child: Text(
                  widget.isPolish ? 'Nasze Usługi' : 'Our Services',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.michroma(
                    fontSize: isSmallScreen ? 24.0 : 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: _dividerWidthAnimation,
              builder: (context, child) {
                return Container(
                  width: _dividerWidthAnimation.value * screenWidth * 0.8,
                  height: 2,
                  color: Colors.white,
                );
              },
            ),
            const SizedBox(height: 40),
            SlideTransition(
              position: _firstItemOffsetAnimation,
              child: FadeTransition(
                opacity: _firstItemOpacityAnimation,
                child: _buildProjectItem(
                  context,
                  widget.isPolish
                      ? 'Profesjonalni montażyści'
                      : 'Professional Fitters',
                  _buildFittersDescription(),
                  'assets/jbexpo/Pracownicy.png',
                  isImageLeft: true,
                  isLargeScreen: isLargeScreen,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SlideTransition(
              position: _secondItemOffsetAnimation,
              child: FadeTransition(
                opacity: _secondItemOpacityAnimation,
                child: _buildProjectItem(
                  context,
                  widget.isPolish ? 'Logistyka' : 'Logistics',
                  _buildLogisticsDescription(),
                  'assets/jbexpo/Logistyka.png',
                  isImageLeft: false,
                  isLargeScreen: isLargeScreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectItem(
    BuildContext context,
    String title,
    InlineSpan description,
    String imagePath, {
    required bool isImageLeft,
    required bool isLargeScreen,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isImageLeft) ...[
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: isSmallScreen ? 100 : 200,
                    height: isSmallScreen ? 150 : 300,
                  ),
                ),
              ),
              const SizedBox(width: 20),
            ],
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.michroma(
                      fontSize:
                          isLargeScreen ? 42.0 : (isSmallScreen ? 18.0 : 24.0),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedBuilder(
                    animation: _widthAnimation,
                    builder: (context, child) {
                      return Container(
                        width: _widthAnimation.value * screenWidth * 0.2,
                        height: 2,
                        color: Colors.white,
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    textAlign: TextAlign.center,
                    text: description,
                  ),
                ],
              ),
            ),
            if (!isImageLeft) ...[
              const SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: isSmallScreen ? 100 : 200,
                    height: isSmallScreen ? 150 : 300,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  TextSpan _buildFittersDescription() {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    return TextSpan(
      style: GoogleFonts.michroma(
        fontSize: isSmallScreen ? 12.0 : 16.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      children: [
        TextSpan(text: widget.isPolish ? 'Posiadamy ' : 'We have a '),
        TextSpan(
          text: widget.isPolish ? 'doświadczony zespół' : 'professional team',
          style: const TextStyle(color: Color.fromARGB(255, 194, 181, 0)),
        ),
        TextSpan(
          text: widget.isPolish
              ? ', który zajmuje się montażem stoisk oraz demontażem po wydarzeniu. Dbamy o '
              : ', handling booth assembly and disassembly. We ensure ',
        ),
        TextSpan(
          text: widget.isPolish ? 'precyzję' : 'precision',
          style: const TextStyle(color: Color.fromARGB(255, 194, 181, 0)),
        ),
        TextSpan(
          text: widget.isPolish
              ? ' i sprawną organizację pracy.'
              : ' and smooth organization.',
        ),
      ],
    );
  }

  TextSpan _buildLogisticsDescription() {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return TextSpan(
      style: GoogleFonts.michroma(
        fontSize: isSmallScreen ? 12.0 : 16.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      children: [
        TextSpan(text: widget.isPolish ? 'Bierzemy ' : 'We take '),
        TextSpan(
          text: widget.isPolish
              ? 'pełną odpowiedzialność'
              : 'full responsibility',
          style: const TextStyle(color: Color.fromARGB(255, 194, 181, 0)),
        ),
        TextSpan(
          text: widget.isPolish
              ? ' za transport stoisk na wydarzenia targowe. Klienci nie muszą się '
              : ' for transporting booths to trade events. Clients don’t have to ',
        ),
        TextSpan(
          text:
              widget.isPolish ? 'martwić o logistykę' : 'worry about logistics',
          style: const TextStyle(color: Color.fromARGB(255, 194, 181, 0)),
        ),
        TextSpan(
          text: widget.isPolish
              ? ' — dostarczamy na czas i w idealnym stanie.'
              : ' — we deliver on time and in perfect condition.',
        ),
      ],
    );
  }
}
