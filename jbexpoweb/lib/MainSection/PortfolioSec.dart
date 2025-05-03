import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PortfolioSec extends StatefulWidget {
  final bool isPolish;
  final Function(int) onNavigate;

  const PortfolioSec({
    Key? key,
    required this.isPolish,
    required this.onNavigate,
  }) : super(key: key);

  @override
  _PortfolioSecState createState() => _PortfolioSecState();
}

class _PortfolioSecState extends State<PortfolioSec>
    with SingleTickerProviderStateMixin {
  final Random _random = Random();
  List<int> _imageIndexes = [];
  int _currentChangingIndex = 0;
  late Timer _timer;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _imageIndexes = _generateUniqueIndexes();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _imageIndexes[_currentChangingIndex] = _generateNewUniqueIndex();
        _currentChangingIndex = (_currentChangingIndex + 1) % 4;
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();
  }

  List<int> _generateUniqueIndexes() {
    List<int> availableIndexes = List.generate(21, (index) => index + 1);
    availableIndexes.shuffle();
    return availableIndexes.take(4).toList();
  }

  int _generateNewUniqueIndex() {
    List<int> availableIndexes = List.generate(21, (index) => index + 1)
      ..removeWhere((index) => _imageIndexes.contains(index));
    if (availableIndexes.isEmpty) {
      return _random.nextInt(21) + 1;
    }
    availableIndexes.shuffle();
    return availableIndexes.first;
  }

  void _changeImages() {
    setState(() {
      _imageIndexes = _generateUniqueIndexes();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerSize = screenWidth < 600
        ? screenWidth * 0.70 // na telefonie obrazek prawie pełny ekran
        : screenWidth * 0.39;

    final bool isMobile = screenWidth < 800;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isMobile)
                _buildMobileLayout(containerSize)
              else
                _buildDesktopLayout(containerSize),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(double containerSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildImageGrid(containerSize),
        const SizedBox(width: 40),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTitle(fontSize: 80),
              _buildMiddleSection(),
              _buildDescription(fontSize: 18),
              const SizedBox(height: 40),
              _buildResponsiveButton(
                label: widget.isPolish
                    ? "Przejdź do pełnego portfolio"
                    : "Go to Full Portfolio",
                onPressed: () => widget.onNavigate(2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(double containerSize) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        _buildTitle(fontSize: 30.0),
        _buildMiddleSection(),
        _buildImageGrid(containerSize),
        const SizedBox(height: 20),
        _buildDescription(fontSize: screenWidth < 600 ? 12 : 16),
        const SizedBox(height: 16),
        _buildResponsiveButton(
          label: widget.isPolish
              ? "Przejdź do pełnego portfolio"
              : "Go to Full Portfolio",
          onPressed: () => widget.onNavigate(2),
        ),
      ],
    );
  }

  Widget _buildMiddleSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Divider(
        color: Color.fromARGB(255, 255, 255, 255),
        thickness: 2,
        indent: 50,
        endIndent: 50,
      ),
    );
  }

  Widget _buildTitle({required double fontSize}) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        widget.isPolish ? "Nasze portfolio" : "Our portfolio",
        textAlign: TextAlign.center,
        style: GoogleFonts.michroma(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 216, 216, 216),
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(3, 3),
              blurRadius: 6,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGrid(double containerSize) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: containerSize,
          height: containerSize,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              final imagePath = 'assets/Stoiska/${_imageIndexes[index]}.png';
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: ClipRRect(
                  key: ValueKey<int>(_imageIndexes[index]),
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 25),
        _buildResponsiveButton(
          label: widget.isPolish ? "Zmień zdjęcia" : "Change Images",
          onPressed: _changeImages,
        ),
      ],
    );
  }

  Widget _buildDescription({required double fontSize}) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: GoogleFonts.michroma(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        children: [
          TextSpan(
            text: widget.isPolish
                ? "Nasze portfolio to unikalne projekty stoisk targowych, które wyróżniają firmy na międzynarodowych wydarzeniach. "
                : "Our portfolio features unique trade booth designs that make businesses stand out at global events. ",
            style: GoogleFonts.michroma(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: widget.isPolish
                ? "Kreatywność i precyzja to podstawa naszych projektów."
                : "Creativity and precision are at the core of our designs.",
            style: GoogleFonts.michroma(
              color: const Color.fromARGB(255, 194, 181, 0),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;

    double fontSize = screenWidth > 1200
        ? 16
        : screenWidth > 800
            ? 18
            : 12;
    double horizontalPadding = screenWidth > 1200
        ? 32
        : screenWidth > 800
            ? 26
            : 16;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 12.0,
        ),
        backgroundColor: const Color.fromARGB(96, 94, 94, 94),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            color: Color.fromARGB(255, 194, 181, 0),
            width: 1.0,
          ),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          style: GoogleFonts.michroma(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
