import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_player/Model/duration_model.dart';
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
  LandscapePlayerWidget(
      {super.key, required this.obj});

  @override
  State<LandscapePlayerWidget> createState() => _LandscapePlayerWidgetState();
}

class _LandscapePlayerWidgetState extends State<LandscapePlayerWidget> {

  @override
  void initState() {
    super.initState();
  }

/*
  void _fillVideoSize() {
    final providV = Provider.of<ProviderVideo>(context);
    bool isFullScreen = providV.isFullScreen;
    final bool isPortrait = providV.isPortrait;
    final bool? isLanscape = providV.isDragUp;
    final srceen = Screen();
    if (!isPortrait) {
    
    } else if (isFullScreen && !isLanscape) {
   
    } else if (isFullScreen) {
      fullVal();
    } else {
      screenHeight = srceen.width * 0.25;
      screenWidth = srceen.width * 0.4;
    }
    widget.obj.changeWidth(screenWidth);
  }*/

  @override
  Widget build(BuildContext context) {
    // _fillVideoSize();
    //Provider.of<ProviderVideo>(context, listen: false).playerAutoSize;
    final providV = Provider.of<ProviderVideo>(context);

    return Container(
        // duration: MyTimes().timePlayer,
        color: Colors.black,
        height: providV.playerHeight,
        width: providV.playerWidth,
        child: VideoPlayerFullScreen(
            obj: widget.obj));
  }
}
