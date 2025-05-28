import 'package:flutter/material.dart';
import 'package:jbexpoweb/loading_widget.dart';
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
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    setState(() {
      _error = false;
    });

    _controller = VideoPlayerController.network(
      'https://raw.githubusercontent.com/SzymonCzermak/jbexpoweb/main/jbexpoweb/assets/JBExpoPlus_Loga.mp4',
    )
      ..setVolume(0)
      ..setLooping(true)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _controller.play();
          });
        }
      }).catchError((e) {
        debugPrint("Video Initialization Error: $e");
        setState(() {
          _error = true;
        });
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
            width: screenWidth,
            height: screenHeight,
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
              child: _error
                  ? _buildErrorContent()
                  : _controller.value.isInitialized
                      ? FittedBox(
                          fit: BoxFit.contain,
                          child: SizedBox(
                            width: _controller.value.size.width,
                            height: _controller.value.size.height,
                            child: VideoPlayer(_controller),
                          ),
                        )
                      : _buildLoading(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() {
    return const AnimatedLoadingWidget();
  }

  Widget _buildErrorContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.redAccent, size: 48),
          const SizedBox(height: 16),
          const Text(
            'Nie udało się załadować filmu.',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              _controller.dispose();
              _initializeVideo();
            },
            child: const Text('Spróbuj ponownie'),
          ),
        ],
      ),
    );
  }
}
