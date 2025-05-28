import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jbexpoweb/FooterWidget.dart';

class PortfolioPage extends StatefulWidget {
  final bool isPolish;

  const PortfolioPage({Key? key, required this.isPolish}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> _projects = List.generate(
    30,
    (index) => {
      "imagePath": 'assets/Stoiska/${index + 1}.png',
    },
  );

  final List<bool> _hoverStates = List.generate(30, (_) => false);
  final Map<String, bool> _imageLoaded = {};

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final int crossAxisCount = screenWidth < 600
        ? 1
        : screenWidth < 900
            ? 2
            : 3;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Listener(
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
                          radius: 2,
                          colors: [
                            Color.fromARGB(100, 255, 0, 0), // Czerwony rozbłysk
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
                  _buildPageTitle(),
                  const DividerWidget(),
                  _buildGallery(crossAxisCount),
                  const DividerWidget(),
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

  Widget _buildPageTitle() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double titleFontSize = constraints.maxWidth > 800 ? 80 : 28;
        double subtitleFontSize = constraints.maxWidth > 800 ? 24 : 16;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.isPolish ? "Nasze Portfolio" : "Our Portfolio",
              style: GoogleFonts.michroma(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 194, 181, 0),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.isPolish
                  ? "Odzwierciedla naszą pasję, doświadczenie oraz profesjonalizm"
                  : "Spaces that shape your brand's image",
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
    );
  }

  Widget _buildGallery(int crossAxisCount) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1,
          ),
          itemCount: _projects.length,
          itemBuilder: (context, index) {
            return _buildGridItem(
              imagePath: _projects[index]['imagePath']!,
              isHovered: _hoverStates[index],
              onHover: (hovered) {
                setState(() {
                  _hoverStates[index] = hovered;
                });
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildGridItem({
    required String imagePath,
    required bool isHovered,
    required Function(bool) onHover,
  }) {
    final alreadyLoaded = _imageLoaded[imagePath] == true;

    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: () => _showFullScreenImage(imagePath),
        child: AnimatedScale(
          scale: isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: alreadyLoaded
              ? _buildImageContainer(imagePath)
              : FutureBuilder<void>(
                  future: _loadImage(imagePath),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return _buildLoader();
                    }
                    _imageLoaded[imagePath] = true;
                    return _buildImageContainer(imagePath);
                  },
                ),
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromARGB(134, 194, 181, 0),
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Color.fromARGB(255, 194, 181, 0),
        ),
      ),
    );
  }

  Widget _buildImageContainer(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromARGB(134, 194, 181, 0),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }

  Future<void> _loadImage(String path) {
    final completer = Completer<void>();
    final image = AssetImage(path);
    final config = createLocalImageConfiguration(context);

    image.resolve(config).addListener(
          ImageStreamListener(
            (info, _) => completer.complete(),
            onError: (_, __) => completer.complete(),
          ),
        );

    return completer.future;
  }

  void _showFullScreenImage(String imagePath) {
    showDialog(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
