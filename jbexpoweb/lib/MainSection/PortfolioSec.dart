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

class _PortfolioSecState extends State<PortfolioSec> {
  final Random _random = Random();
  List<int> _imageIndexes = [1, 2, 3, 4];
  int _currentChangingIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _imageIndexes[_currentChangingIndex] = _random.nextInt(21) + 1;
        _currentChangingIndex = (_currentChangingIndex + 1) % 4;
      });
    });
  }

  void _changeImages() {
    setState(() {
      _imageIndexes = List.generate(4, (index) => _random.nextInt(21) + 1);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerSize =
        screenWidth < 400 ? screenWidth * 0.9 : screenWidth * 0.39;
    final bool isMobile = screenWidth < 800;

    return Padding(
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        _buildTitle(fontSize: 30.0),
        _buildMiddleSection(),
        _buildImageGrid(containerSize),
        const SizedBox(height: 20),
        _buildDescription(fontSize: 16),
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
