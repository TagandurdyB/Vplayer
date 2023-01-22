import 'dart:io';
import 'package:flutter/material.dart';
import 'package:local_player/ViewModel/Providers/provider_video.dart';
import 'package:local_player/ViewModel/screen_values.dart';
import 'package:provider/provider.dart';
import '/View/Widget/full_screen_player_widget.dart';
import 'package:video_player/video_player.dart';

class PortraitPlayerWidget extends StatefulWidget {
  final File videoFile;
  const PortraitPlayerWidget({super.key, required this.videoFile});

  @override
  State<PortraitPlayerWidget> createState() => _PortraitPlayerWidgetState();
}

class _PortraitPlayerWidgetState extends State<PortraitPlayerWidget> {
  late VideoPlayerController videoController;
  late double videoWidth;
  late double videoHeight;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.file(widget.videoFile)
      ..addListener(() => setState(() {}))
      // ..setLooping(true)
      ..initialize().then((_) => videoController.play());
    videoWidth = Screen().width;
    videoHeight = Screen().height;
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFullScreen = Provider.of<ProviderVideo>(context).isFullScreen;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            color: Colors.red,
            height: isFullScreen
                ? videoWidth * 0.6
                : videoHeight * 0.1, // videoHeight,
            width: isFullScreen ? videoWidth : videoHeight * 0.16,
            child: VideoPlayerFullScreen(videoController: videoController)),
        Visibility(
            visible: isFullScreen,
            child: Container(
              width: 100,
              height: 50,
              color: Colors.red,
            ))
      ],
    );
  }
}
