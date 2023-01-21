import 'package:flutter/material.dart';
import '/View/Widget/basic_overlay_widget.dart';
import '/View/Widget/my_container.dart';
import '/ViewModel/Providers/provider_video.dart';
import '/ViewModel/screen_values.dart';
import 'package:provider/provider.dart';
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
    //Provider.of<ProviderVideo>(context, listen: false).ch;
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
    //final providerV = Provider.of<ProviderVideo>(context, listen: false);
    return Container(
      color: Colors.black54,
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
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
    //   final providerV = Provider.of<ProviderVideo>(context, listen: false);
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

  Widget buildPausePlayBtn(bool isPause) => MyContainer(
        color: Colors.transparent,
        onTap: tongelePlay,
        child: Icon(
          isPause ? Icons.pause : Icons.play_arrow,
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
