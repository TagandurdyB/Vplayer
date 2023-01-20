import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BasicOverlyWidget extends StatelessWidget {
  final VideoPlayerController videoController;
  const BasicOverlyWidget({super.key, required this.videoController});

  @override
  Widget build(BuildContext context) {
   
    return Stack(
      alignment: Alignment.center,
      children: [
        buildIndicator(),
      ],
    );
  }

  Widget buildIndicator() =>
      VideoProgressIndicator(videoController, allowScrubbing: true);
}
