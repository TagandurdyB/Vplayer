import 'package:flutter/material.dart';
import 'package:local_player/Model/video_model.dart';
import 'package:local_player/View/Widget/video_forward_btns_w.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../ViewModel/Providers/provider_video.dart';
import 'my_container.dart';

// ignore: must_be_immutable
class VideoPlayerFullScreen extends StatelessWidget {
  final VideoPlayerController videoController;
  final VideoObj obj;
  VideoPlayerFullScreen(
      {super.key, required this.videoController, required this.obj});

  bool isPause = false;
  bool isFullScreen = true;

  @override
  Widget build(BuildContext context) => videoController.value.isInitialized
      ? AspectRatio(
          aspectRatio: videoController.value.aspectRatio,
          child: Stack(
            alignment: Alignment.center,
            children: [
              MyContainer(
                  onTap: () => _showBtns(context),
                  color: Colors.black,
                  child: buildVideo()),
              Visibility(
                visible: Provider.of<ProviderVideo>(context).isForwardBtnsShow,
                child: VideoForwardBtns(
                  videoController: videoController,
                  obj: obj,
                ),
              )
            ],
          ))
      : const Center(child: CircularProgressIndicator(color: Colors.red));

  void _showBtns(BuildContext context) =>
      Provider.of<ProviderVideo>(context, listen: false).tongleForvardBtns;

  Widget buildVideo() => buildVideoPlayer();
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
