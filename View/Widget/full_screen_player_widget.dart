import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'my_container.dart';

// ignore: must_be_immutable
class VideoPlayerFullScreen extends StatelessWidget {
  final VideoPlayerController videoController;
  VideoPlayerFullScreen({super.key, required this.videoController});

  bool isPause = false;
  bool isFullScreen = true;



  @override
  Widget build(BuildContext context) => videoController.value.isInitialized
      ? AspectRatio(
          aspectRatio: videoController.value.aspectRatio,
          child:  Stack(
                alignment: Alignment.center,
                children: [
                  MyContainer(
                      //  onTap: _showBtns,
                      child: buildVideo()),
                  /*               Visibility(
                    visible:
                        Provider.of<ProviderVideo>(context).isForwardBtnsShow,
                    child: btnGroup(),
                  )*/
                ],
              ))
      : const Center(child: CircularProgressIndicator(color: Colors.red));

  Widget buildVideo() => Stack(
        fit: StackFit.expand,
        children: [
          buildVideoPlayer(),
        ],
      );
  Widget buildVideoPlayer() => Center(
        child: buildFullScreen(
            child: AspectRatio(
                aspectRatio: videoController.value.aspectRatio,
                child: VideoPlayer(videoController))),
      );

  Widget buildFullScreen({
    required Widget child,
  }) {
    final size = videoController.value.size;
    final double width = size.width;
    final double height = size.height;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}
