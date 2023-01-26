import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BasicOverlyWidget extends StatelessWidget {
  final VideoPlayerController videoController;
  final bool allowScrubbing;
  const BasicOverlyWidget(
      {super.key, required this.videoController, this.allowScrubbing = true});

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
      VideoProgressIndicator(videoController, allowScrubbing: allowScrubbing);
}
