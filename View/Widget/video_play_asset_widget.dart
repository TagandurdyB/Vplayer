import 'dart:async';

import 'package:flutter/material.dart';
import 'package:player/View/Widget/my_container.dart';
import 'package:player/ViewModel/screen_values.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerAssetWidget extends StatefulWidget {
  final double? width;
  final double? height;
  const VideoPlayerAssetWidget({super.key, this.width, this.height});

  @override
  State<VideoPlayerAssetWidget> createState() => _VideoPlayerAssetWidgetState();
}

class _VideoPlayerAssetWidgetState extends State<VideoPlayerAssetWidget> {
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

  bool _isBtnsShow = false;
  bool _isPause = false;

  double playerWidth = 0.0;
  double playerHeight = 0.0;

  @override
  Widget build(BuildContext context) {
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
                      visible: _isBtnsShow,
                      child: btnGroup(),
                    )
                  ],
                );
              },
            ))
        : Container(
            alignment: Alignment.center,
            width: widget.width,
            height: widget.height,
            color: Colors.black,
            child: const CircularProgressIndicator(),
          );
  }

  void _showBtns() {
    setState(() {
      _isBtnsShow = true;
      btnTimer(3);
    });
  }

  void btnTimer(int second) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (second > 0 && !_isPause) second--;
      if (second == 0) {
        timer.cancel();
        _isBtnsShow = false;
        setState(() {});
      }
    });
  }

  Widget btnGroup() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.skip_previous,
              size: playerWidth * 0.2,
              color: Colors.white,
            ),
            MyContainer(
              color: Colors.transparent,
              onTap: tongelePlay,
              child: Icon(
                _isPause ? Icons.pause : Icons.play_arrow,
                size: playerWidth * 0.3,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.skip_next,
              size: playerWidth * 0.2,
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }

  void tongelePlay() => setState(() {
        _isPause = !_isPause;
        _isPause?videoController.pause():videoController.play();
      });
}
