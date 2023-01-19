import 'package:flutter/material.dart';
import 'package:player/ViewModel/screen_values.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerFileWidget extends StatefulWidget {
  final double? width;
  final double? height;
  const VideoPlayerFileWidget({super.key, this.width, this.height});

  @override
  State<VideoPlayerFileWidget> createState() => _VideoPlayerFileWidgetState();
}

class _VideoPlayerFileWidgetState extends State<VideoPlayerFileWidget> {
  final scren = Screen();
  final String assetVideo = "assets/test1.mp4";
  late VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.asset(assetVideo)
      ..addListener(() => setState(() {}))
      // ..setLooping(true)
      ..initialize().then((_) => videoController.play());
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoController.value.isInitialized
        ? AspectRatio(
            aspectRatio: videoController.value.aspectRatio,
            child: VideoPlayer(videoController))
        : Container(
            alignment: Alignment.center,
            width: widget.width,
            height: widget.height,
            color: Colors.black,
            child: const CircularProgressIndicator(),
          );
  }
}
