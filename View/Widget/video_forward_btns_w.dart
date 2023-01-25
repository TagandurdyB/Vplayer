import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_player/View/Widget/settings_sheed.dart';
import 'package:local_player/ViewModel/Providers/provider_file.dart';
import 'package:local_player/ViewModel/time_converter.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../Model/video_model.dart';
import '../../ViewModel/Providers/provider_video.dart';
import '../../ViewModel/screen_values.dart';
import 'basic_overlay_widget.dart';
import 'my_container.dart';

// ignore: must_be_immutable
class VideoForwardBtns extends StatefulWidget {
  final VideoPlayerController videoController;
  final VideoObj obj;
  const VideoForwardBtns(
      {super.key, required this.videoController, required this.obj});

  @override
  State<VideoForwardBtns> createState() => _VideoForwardBtnsState();
}

class _VideoForwardBtnsState extends State<VideoForwardBtns> {
  final screen = Screen();

  late bool isFullScreen;

  late bool isPause;

  late double videoWidth;
  late double videoHeight;

  @override
  Widget build(BuildContext context) {
    final providerV = Provider.of<ProviderVideo>(context);
    isFullScreen = providerV.isFullScreen;
    isPause = providerV.isVideoPause;
    return LayoutBuilder(builder: (context, constraints) {
      videoWidth = constraints.maxWidth;
      videoHeight = constraints.maxHeight;
      return btnGroup();
    });
  }

  Widget btnGroup() {
    return GestureDetector(
      onDoubleTapDown: (detail) =>
          Provider.of<ProviderVideo>(context, listen: false)
              .changeDoubleTabSide(detail.globalPosition.dx.round()),
      onDoubleTap: _onDoubleTab,
      onTap: _showBtns,
      child: Container(
        color: Colors.black54,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            buildVideoActions(),
            Visibility(
                visible: !Provider.of<ProviderVideo>(context).isFastBtnsUse,
                child: buildCenterBtns()),
            buildBottomGroup(),
          ],
        ),
      ),
    );
  }

  void _onDoubleTab() => Provider.of<ProviderVideo>(context, listen: false)
      .doubleTab(widget.videoController);

  void _showBtns() => Provider.of<ProviderVideo>(context, listen: false)
      .changeForwardShow(true);

  Widget buildBottomGroup() => Visibility(
        visible: isFullScreen,
        child: Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(screen.width * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTimer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 5.0),
                      child: buildVideoIndicator(),
                    )),
                    buildScreenChangeBtn(),
                  ],
                ),
              ],
            )),
      );

  Widget buildTimer() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          TimeConterter(widget.videoController).getTime,
          style: TextStyle(fontSize: screen.width * 0.03),
        ),
      );

  Widget buildScreenChangeBtn() {
    final bool isPortrait = Provider.of<ProviderVideo>(context).isPortrait;
    return MyContainer(
        onTap: isPortrait ? funcLandscape : funcPortrate,
        color: Colors.transparent,
        child: Icon(
          isPortrait ? Icons.fullscreen : Icons.fullscreen_exit,
          color: Colors.grey[300],
        ));
  }

  void setLandscape() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
     
  }

void funcLandscape(){
  setLandscape();
Provider.of<ProviderVideo>(context, listen: false).changeOrientation(false);
}

  void setPortrate() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }
void funcPortrate(){
  setPortrate();
Provider.of<ProviderVideo>(context, listen: false).changeOrientation(true);
}


  Widget buildCenterBtns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildVideoChanger(false),
        buildPausePlayBtn(),
        buildVideoChanger(true),
      ],
    );
  }

  Widget buildVideoChanger(bool isNext) => MyContainer(
        //   onTap: () => _changeVideo(isNext),
        color: Colors.transparent,
        child: Icon(
          isNext ? Icons.skip_next : Icons.skip_previous,
          size: videoWidth * 0.12,
          color: Colors.white,
        ),
      );

  void _checkVideo() {
    final value = widget.videoController.value;
    if (value.position == value.duration) {
      _changeVideo(true);
      debugPrint("Video end");
    }
  }

  late int index;
  void _changeVideo(bool isNext) {
    index = widget.obj.index;
    final int length =
        Provider.of<ProviderFile>(context, listen: false).videos.length;
    if (isNext) {
      index++;
      if (index >= length) {
        index = 0;
      }
    } else {
      index = index - 1;
      if (index < 0) {
        index = length - 1;
      }
    }
    _settingModelBottomSheed();
  }

  void _settingModelBottomSheed() {
    final providerF = Provider.of<ProviderFile>(context, listen: false);
    final providerV = Provider.of<ProviderVideo>(context, listen: false);
    providerV.startVideo;
    providerV.changeVideoObj(providerF.videos[index]);
    debugPrint("sheed open!");
  }

  Widget buildVideoActions() => Visibility(
      visible: isFullScreen,
      child: Container(
          alignment: Alignment.topRight,
          padding: EdgeInsets.all(screen.width * 0.02),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            IconButton(
                onPressed: _settingSheed,
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey[300],
                )),
          ])));

  void _settingSheed() {
    showBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        backgroundColor: Colors.white,
        enableDrag: true,
        context: context,
        builder: (BuildContext context) {
          return const SettingsSheed();
        });
  }

  Widget buildPausePlayBtn() => MyContainer(
        color: Colors.transparent,
        onTap: tongelePlay,
        child: Icon(
          Provider.of<ProviderVideo>(context, listen: false).isVideoPause
              ? Icons.play_arrow
              : Icons.pause,
          size: videoWidth * 0.2,
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
