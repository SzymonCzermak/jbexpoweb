import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class S1Section extends StatefulWidget {
  final bool isPolish;

  const S1Section({Key? key, required this.isPolish}) : super(key: key);

  @override
  _S1SectionState createState() => _S1SectionState();
}

class _S1SectionState extends State<S1Section> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  late AnimationController _textController;
  late Animation<Offset> _textOffsetAnimation;
  late Animation<double> _textOpacityAnimation;

  late AnimationController _serviceController;
  late Animation<Offset> _serviceOffsetAnimation;
  late Animation<double> _serviceOpacityAnimation;

  late AnimationController _dividerController;
  late Animation<double> _dividerWidthAnimation;

  late AnimationController _productionController;
  late Animation<Offset> _productionOffsetAnimation;
  late Animation<double> _productionOpacityAnimation;

  late AnimationController _equipmentController;
  late Animation<Offset> _equipmentOffsetAnimation;
  late Animation<double> _equipmentOpacityAnimation;

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

    _serviceController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _serviceOffsetAnimation =
        Tween<Offset>(begin: Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _serviceController,
        curve: Curves.easeInOut,
      ),
    );

    _serviceOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _serviceController,
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

    _productionController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _productionOffsetAnimation =
        Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _productionController,
        curve: Curves.easeInOut,
      ),
    );

    _productionOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _productionController,
        curve: Curves.easeInOut,
      ),
    );

    _equipmentController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _equipmentOffsetAnimation =
        Tween<Offset>(begin: Offset(1, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _equipmentController,
        curve: Curves.easeInOut,
      ),
    );

    _equipmentOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _equipmentController,
        curve: Curves.easeInOut,
      ),
    );

    _textController.forward().then((_) {
      _serviceController.forward().then((_) {
        _dividerController.forward().then((_) {
          _productionController.forward().then((_) {
            _equipmentController.forward();
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    _serviceController.dispose();
    _dividerController.dispose();
    _productionController.dispose();
    _equipmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isSmallScreen = screenWidth < 600;
    final bool isLargeScreen = screenWidth > 1200;

    final double scaleFactor = screenHeight < 800 ? screenHeight / 800 : 1.0;

    return Transform.scale(
      scale: scaleFactor,
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 16.0 : screenWidth * 0.1,
        ),
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
                    color: const Color.fromARGB(255, 255, 255, 255),
                  );
                },
              ),
              const SizedBox(height: 40),
              SlideTransition(
                position: _productionOffsetAnimation,
                child: FadeTransition(
                  opacity: _productionOpacityAnimation,
                  child: _buildServiceItem(
                    context,
                    widget.isPolish ? 'Produkcja' : 'Production',
                    _buildProductionDescription(),
                    'assets/jbexpo/Produkcja.png',
                    isImageLeft: true,
                    isLargeScreen: isLargeScreen,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SlideTransition(
                position: _equipmentOffsetAnimation,
                child: FadeTransition(
                  opacity: _equipmentOpacityAnimation,
                  child: _buildServiceItem(
                    context,
                    widget.isPolish
                        ? 'Profesjonalny sprzęt'
                        : 'Professional Equipment',
                    _buildEquipmentDescription(),
                    'assets/jbexpo/Sprzet.png',
                    isImageLeft: false,
                    isLargeScreen: isLargeScreen,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, String title,
      InlineSpan description, String imagePath,
      {required bool isImageLeft, required bool isLargeScreen}) {
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
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedBuilder(
                    animation: _widthAnimation,
                    builder: (context, child) {
                      return Container(
                        width: _widthAnimation.value * screenWidth * 0.2,
                        height: 2,
                        color: const Color.fromARGB(255, 255, 255, 255),
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

  TextSpan _buildProductionDescription() {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    return TextSpan(
      style: GoogleFonts.michroma(
        fontSize: isSmallScreen ? 12.0 : 16.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      children: [
        TextSpan(text: widget.isPolish ? 'Dzięki ' : 'Thanks to our '),
        TextSpan(
          text: widget.isPolish ? 'własnej produkcji' : 'own production',
          style: const TextStyle(color: Color.fromARGB(255, 194, 181, 0)),
        ),
        TextSpan(
            text: widget.isPolish
                ? ' i zaangażowaniu pracowników, nasza firma realizuje stoiska targowe o każdej wielkości — zarówno '
                : ' and employee engagement, our company builds booths of any size — both '),
        TextSpan(
          text: widget.isPolish ? 'małe' : 'small',
          style: const TextStyle(color: Color.fromARGB(255, 194, 181, 0)),
        ),
        TextSpan(text: widget.isPolish ? ' jak i ' : ' and '),
        TextSpan(
          text: widget.isPolish ? 'duże.' : 'large.',
          style: const TextStyle(color: Color.fromARGB(255, 194, 181, 0)),
        ),
      ],
    );
  }

  TextSpan _buildEquipmentDescription() {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return TextSpan(
      style: GoogleFonts.michroma(
        fontSize: isSmallScreen ? 12.0 : 16.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      children: [
        TextSpan(
            text: widget.isPolish
                ? 'Nasza firma dysponuje '
                : 'Our company has '),
        TextSpan(
          text: widget.isPolish
              ? 'profesjonalnym sprzętem'
              : 'professional equipment',
          style: const TextStyle(color: Color.fromARGB(255, 194, 181, 0)),
        ),
        TextSpan(
            text: widget.isPolish
                ? ', w tym maszyną CNC, która zapewnia '
                : ', including a CNC machine that ensures '),
        TextSpan(
          text:
              widget.isPolish ? 'najwyższą precyzję' : 'the highest precision',
          style: const TextStyle(color: Color.fromARGB(255, 194, 181, 0)),
        ),
        TextSpan(text: widget.isPolish ? ' i ' : ' and '),
        TextSpan(
          text: widget.isPolish ? 'dokładność' : 'accuracy',
          style: const TextStyle(color: Color.fromARGB(255, 194, 181, 0)),
        ),
        TextSpan(
            text: widget.isPolish
                ? ' w produkcji stoisk targowych.'
                : ' in the production of trade booths.'),
      ],
    );
  }
}
