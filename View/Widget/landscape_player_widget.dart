import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_player/Model/video_model.dart';
import 'package:local_player/ViewModel/Providers/provider_video.dart';
import 'package:local_player/ViewModel/screen_values.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/durations_vm.dart';
import '/View/Widget/full_screen_player_widget.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class LandscapePlayerWidget extends StatefulWidget {
  VideoObj obj;
  VideoPlayerController videoController;
  LandscapePlayerWidget({super.key, required this.obj,required this.videoController});

  @override
  State<LandscapePlayerWidget> createState() => _LandscapePlayerWidgetState();
}

class _LandscapePlayerWidgetState extends State<LandscapePlayerWidget> {
  late VideoPlayerController videoController;
  late double screenWidth;
  late double screenHeight;

  @override
  void initState() {
    super.initState();
    videoController = widget.videoController;
  }



  void setLandscape() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void setPortrate() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }

  void _fillVideoSize() {
    final providV = Provider.of<ProviderVideo>(context);
    bool isFullScreen = providV.isFullScreen;
    final bool isPortrait = providV.isPortrait;
    final srceen = Screen();
    if (!isPortrait) {
      screenHeight = srceen.playerLandscapeHeight;
      screenWidth = srceen.playerLandscapeWidth;
    } else if (isFullScreen) {
      screenHeight = srceen.width * 0.6;
      screenWidth = srceen.width;
    } else {
      screenHeight = srceen.width * 0.25;
      screenWidth = srceen.width * 0.4;
    }
    widget.obj.changeWidth(screenWidth);
  }

  @override
  Widget build(BuildContext context) {
    _fillVideoSize();

    return AnimatedContainer(
        duration: MyTimes().timePlayer,
        color: Colors.black,
        height: screenHeight,
        width: screenWidth,
        child: VideoPlayerFullScreen(
            obj: widget.obj, videoController: videoController));
  }
}
