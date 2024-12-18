import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoSection extends StatefulWidget {
  final double borderRadius; // Zaokrąglenie ramki
  final double borderWidth; // Grubość ramki
  final Color borderColor; // Kolor ramki
  final double shadowBlurRadius; // Rozmycie cienia
  final double shadowSpreadRadius; // Rozciągnięcie cienia
  final Color shadowColor; // Kolor cienia

  const VideoSection({
    Key? key,
    this.borderRadius = 0.0,
    this.borderWidth = 0.0,
    this.borderColor = Colors.black,
    this.shadowBlurRadius = 0.0,
    this.shadowSpreadRadius = 0.0,
    this.shadowColor = Colors.black,
  }) : super(key: key);

  @override
  _VideoSectionState createState() => _VideoSectionState();
}

class _VideoSectionState extends State<VideoSection> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    // Reset kontrolera i inicjalizacja od początku
    _controller = VideoPlayerController.asset('assets/JBExpoPlus_Loga.mp4')
      ..setVolume(0) // Wyciszenie wideo (ważne dla automatycznego startu)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _controller.play();
            _controller.setLooping(true);
          });
        }
      }).catchError((e) {
        debugPrint("Video Initialization Error: $e");
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        return Center(
          child: Container(
            width: screenWidth, // Pełna szerokość ekranu
            height: screenHeight, // Pełna wysokość ekranu
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: [
                BoxShadow(
                  color: widget.shadowColor.withOpacity(0.5),
                  spreadRadius: widget.shadowSpreadRadius,
                  blurRadius: widget.shadowBlurRadius,
                  offset: const Offset(4, 4),
                ),
              ],
              border: Border.all(
                color: widget.borderColor,
                width: widget.borderWidth,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: _controller.value.isInitialized
                  ? FittedBox(
                      fit: BoxFit.contain, // Rozciągnięcie filmu na cały ekran
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}
