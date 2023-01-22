import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../ViewModel/Providers/provider_video.dart';
import '../../ViewModel/screen_values.dart';
import 'basic_overlay_widget.dart';
import 'my_container.dart';

// ignore: must_be_immutable
class VideoForwardBtns extends StatefulWidget {
  final VideoPlayerController videoController;
  final double playerWidth;
  const VideoForwardBtns(
      {super.key, required this.videoController, this.playerWidth = 0.0});

  @override
  State<VideoForwardBtns> createState() => _VideoForwardBtnsState();
}

class _VideoForwardBtnsState extends State<VideoForwardBtns> {
  final screen = Screen();

  late bool isFullScreen;

  late bool isPause;

  @override
  Widget build(BuildContext context) {
    final providerV = Provider.of<ProviderVideo>(context);
    isFullScreen = providerV.isFullScreen;
    isPause = providerV.isVideoPause;
    return btnGroup();
  }

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
                padding: EdgeInsets.all(screen.width * 0.02),
                child: buildVideoActions()),
          ),
          buildCenterBtns(),
          buildBottomGroup(),
        ],
      ),
    );
  }

  Widget buildBottomGroup() => Visibility(
        visible: isFullScreen,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(screen.width * 0.04),
                child: buildVideoIndicator()),
            buildFullBtn(),
          ],
        ),
      );

  Widget buildFullBtn() =>
      IconButton(onPressed: () {}, icon: const Icon(Icons.fullscreen));

  Widget buildCenterBtns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          Icons.skip_previous,
          size: widget.playerWidth * 0.12,
          color: Colors.white,
        ),
        buildPausePlayBtn(),
        Icon(
          Icons.skip_next,
          size: widget.playerWidth * 0.12,
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

  Widget buildPausePlayBtn() => MyContainer(
        color: Colors.transparent,
        onTap: tongelePlay,
        child: Icon(
          isPause ? Icons.play_arrow : Icons.pause,
          size: widget.playerWidth * 0.2,
          color: Colors.white,
        ),
      );

  void tongelePlay() {
    final providerV = Provider.of<ProviderVideo>(context, listen: false);
    providerV.tonglePause;
    providerV.isVideoPause
        ? widget.videoController.pause()
        : widget.videoController.play();
  }

  Widget buildVideoIndicator() =>
      BasicOverlyWidget(videoController: widget.videoController);
}
