import 'dart:io';
import 'package:flutter/material.dart';
import 'package:local_player/Model/video_model.dart';
import 'package:local_player/ViewModel/Providers/provider_video.dart';
import 'package:local_player/ViewModel/screen_values.dart';
import 'package:provider/provider.dart';
import '/View/Widget/full_screen_player_widget.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class PortraitPlayerWidget extends StatefulWidget {
  VideoObj obj;
  PortraitPlayerWidget({super.key, required this.obj});

  @override
  State<PortraitPlayerWidget> createState() => _PortraitPlayerWidgetState();
}

class _PortraitPlayerWidgetState extends State<PortraitPlayerWidget> {
  late VideoPlayerController videoController;
  late double screenWidth;
  late double screenHeight;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.file(widget.obj.videoFile!)
      ..addListener(() => setState(() {}))
      // ..setLooping(true)
      ..initialize().then((_) => videoController.play());
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  void _fillVideoSize() {
    bool isFullScreen = Provider.of<ProviderVideo>(context).isFullScreen;
    final srceen = Screen();
    if (isFullScreen) {
      screenHeight = srceen.width * 0.6;
      screenWidth = srceen.width;
    } else {
      screenHeight = srceen.height * 0.1;
      screenWidth = srceen.height * 0.16;
    }
  }

  @override
  Widget build(BuildContext context) {
    _fillVideoSize();

    return SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: VideoPlayerFullScreen(
            width: screenWidth, videoController: videoController));
  }
}
