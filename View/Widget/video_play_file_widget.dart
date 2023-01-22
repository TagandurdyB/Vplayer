import 'dart:io';

import 'package:flutter/material.dart';
import '/View/Widget/basic_overlay_widget.dart';
import '/View/Widget/my_container.dart';
import '/ViewModel/Providers/provider_video.dart';
import '/ViewModel/screen_values.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerFileWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final File videoFile;
  const VideoPlayerFileWidget(
      {super.key, this.width, this.height, required this.videoFile});

  @override
  State<VideoPlayerFileWidget> createState() => _VideoPlayerFileWidgetState();
}

class _VideoPlayerFileWidgetState extends State<VideoPlayerFileWidget> {
  final scren = Screen();
  late VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.file(widget.videoFile)
      ..addListener(() => setState(() {}))
      // ..setLooping(true)
      ..initialize().then((_) => videoController.play());
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  bool isPause = false;
  bool isFullScreen = true;

  double playerWidth = 0.0;
  double playerHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    final providerV = Provider.of<ProviderVideo>(context);
    isPause = providerV.isVideoPause;
    isFullScreen = providerV.isFullScreen;
    return videoController.value.isInitialized
        ? AspectRatio(
            aspectRatio: videoController.value.aspectRatio,
            child: LayoutBuilder(
              builder: (context, constraints) {
                playerWidth = constraints.maxWidth;
                playerWidth = constraints.maxHeight;
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    MyContainer(
                        onTap: _showBtns, child: VideoPlayer(videoController)),
                    Visibility(
                      visible:
                          Provider.of<ProviderVideo>(context).isForwardBtnsShow,
                      child: btnGroup(),
                    )
                  ],
                );
              },
            ))
        : Container(
            alignment: Alignment.center,
            width: playerWidth,
            height: playerWidth,
            color: Colors.black,
            child: const CircularProgressIndicator(),
          );
  }

  void _showBtns() =>
      Provider.of<ProviderVideo>(context, listen: false).tongleForvardBtns;

  Widget btnGroup() {
    return Container(
      color: Colors.black54,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Visibility(
            visible: isFullScreen,
            child: Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.all(Screen().width * 0.02),
                child: buildVideoActions()),
          ),
          buildCenterBtns(),
          Visibility(
            visible: isFullScreen,
            child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(Screen().width * 0.02),
                child: buildVideoIndicator()),
          ),
        ],
      ),
    );
  }

  Widget buildCenterBtns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          Icons.skip_previous,
          size: playerWidth * 0.2,
          color: Colors.white,
        ),
        buildPausePlayBtn(isPause),
        Icon(
          Icons.skip_next,
          size: playerWidth * 0.2,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget buildVideoActions() => Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: Colors.grey[300],
            )),
      ]);

  Widget buildPausePlayBtn(bool isPause) => MyContainer(
        color: Colors.transparent,
        onTap: tongelePlay,
        child: Icon(
          isPause ? Icons.play_arrow : Icons.pause,
          size: playerWidth * 0.3,
          color: Colors.white,
        ),
      );
  void tongelePlay() {
    final providerV = Provider.of<ProviderVideo>(context, listen: false);
    providerV.tonglePause;
    providerV.isVideoPause ? videoController.pause() : videoController.play();
  }

  Widget buildVideoIndicator() =>
      BasicOverlyWidget(videoController: videoController);
}
