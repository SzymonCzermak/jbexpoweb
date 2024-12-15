import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoSection extends StatefulWidget {
  final double width; // Szerokość wideo
  final double height; // Wysokość wideo
  final double borderRadius; // Zaokrąglenie ramki
  final double borderWidth; // Grubość ramki
  final Color borderColor; // Kolor ramki
  final double shadowBlurRadius; // Rozmycie cienia
  final double shadowSpreadRadius; // Rozciągnięcie cienia
  final Color shadowColor; // Kolor cienia

  const VideoSection({
    Key? key,
    this.width = 3000,
    this.height = 1000,
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
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    // Przekształcenie ścieżki zasobu na URL
    final assetPath = Uri.encodeFull('assets/JBExpoPlus_Loga.mp4');

    // Użycie VideoPlayerController.network zamiast .asset
    _controller = VideoPlayerController.network(
      '/$assetPath', // Ścieżka pliku w formacie URL
    )..initialize().then((_) {
        debugPrint("Video Initialized");
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
    _controller.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.width,
        height: widget.height,
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
          child: _controller.value.isInitialized && _isPlaying
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
