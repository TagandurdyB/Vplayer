import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_player/View/Widget/settings_sheed.dart';
import 'package:local_player/ViewModel/Providers/provider_file.dart';
import 'package:local_player/ViewModel/Providers/provider_orientation.dart';
import 'package:local_player/ViewModel/time_converter.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../Model/video_model.dart';
import '../../ViewModel/Providers/provider_controller.dart';
import '../../ViewModel/Providers/provider_video.dart';
import '../../ViewModel/screen_values.dart';
import 'basic_overlay_widget.dart';
import 'my_container.dart';

// ignore: must_be_immutable
class VideoForwardBtns extends StatefulWidget {
  
  const VideoForwardBtns({super.key});

  @override
  State<VideoForwardBtns> createState() => _VideoForwardBtnsState();
}

class _VideoForwardBtnsState extends State<VideoForwardBtns> {
  final screen = Screen();

  late bool isFullScreen;
  late bool isPause;
  late bool isPortrait;
  late double playerWidth;

  late double videoWidth;
  late double videoHeight;
  late double arentir;
  late BuildContext contextM;

  @override
  Widget build(BuildContext context) {
    final providerV = Provider.of<ProviderVideo>(context);
    isFullScreen = providerV.isFullScreen;
    isPause = providerV.isVideoPause;
    isPortrait = providerV.isPortrait;
    playerWidth = providerV.playerWidth;
    return LayoutBuilder(builder: (context, constraints) {
      videoWidth = constraints.maxWidth;
      videoHeight = constraints.maxHeight;
      arentir = isPortrait ? videoWidth : videoHeight;
      return btnGroup();
    });
  }

  Widget btnGroup() {
    Provider.of<ControlVideo>(context).control.addListener(()=>setState((){}));
    return MyContainer(
      onTap: _showBtns,
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
    );
  }

  void _showBtns() => Provider.of<ProviderVideo>(context, listen: false)
      .changeForwardShow(true);

  Widget buildBottomGroup() => Visibility(
        //  visible: isFullScreen,
        visible: playerWidth != screen.playerMinWidth,
        child: Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(screen.width * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: arentir * 0.02),
                      child: buildVideoIndicator(),
                    )),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: arentir * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          buildTimer(),
                          buildSound(),
                        ],
                      ),
                      buildScreenChangeBtn(),
                    ],
                  ),
                ),
              ],
            )),
      );

  Widget buildTimer() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          TimeConterter(Provider.of<ControlVideo>(context).control).getTime,
          style: TextStyle(fontSize: arentir * 0.03),
        ),
      );
//Volume/////////////////////////////////////////////////////////
  Widget buildSound() => Row(
        children: [
          buildVolumeBtn(),
          buildVolumeSlider(),
        ],
      );

  Widget buildVolumeBtn() {
    final providV = Provider.of<ProviderVideo>(context);
    final providC = Provider.of<ControlVideo>(context);
    final providVdo = Provider.of<ProviderVideo>(context, listen: false);
    return GestureDetector(
      onTap: () {
        providVdo.tongleVolume;
        providC.control.setVolume(providV.setVolume.round() * 0.01);
      },
      child: Icon(
        providV.setVolume >= 50
            ? Icons.volume_up_sharp
            : providV.setVolume == 0
                ? Icons.volume_off_rounded
                : Icons.volume_down,
        color: Colors.grey[300],
        size: arentir * 0.07,
      ),
    );
  }

  Widget buildVolumeSlider() {
    final providVdo = Provider.of<ProviderVideo>(context, listen: false);
    final providC = Provider.of<ControlVideo>(context);
    final providV = Provider.of<ProviderVideo>(context);
    final double setVolume = providV.setVolume;
    return SizedBox(
      width: arentir * 0.4,
      // height: 40,
      child: Slider(
          min: 0,
          max: 100,
          value: setVolume,
          label: "${setVolume.round()}%",
          onChangeStart: (_) {
            _showBtns();
          },
          onChangeEnd: (_) {
            _unShowBtns();
          },
          onChanged: (double value) {
              providVdo.changeVolume(value.round() + 0.0);
              providC.control.setVolume(value.round() * 0.01);
              _showBtns();
          }),
    );
  }

  void _unShowBtns() =>
      Provider.of<ProviderVideo>(context, listen: false).changeForwardShowTrue;
//Landscape-Portrate///////////////////////////////////////////

  Widget buildScreenChangeBtn() {
    final bool isPortrait = Provider.of<ProviderVideo>(context).isPortrait;
    return MyContainer(
        onTap: isPortrait ? funcLandscape : funcPortrate,
        color: Colors.transparent,
        child: Icon(
          isPortrait ? Icons.fullscreen : Icons.fullscreen_exit,
          size: arentir * 0.07,
          color: Colors.grey[300],
        ));
  }

  void funcLandscape() => MyOrientation(context).setLandscape;

  void funcPortrate() => MyOrientation(context).setPortraitUp;
/////////////////////////////////////////////////////////////////

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
        onTap: () => _changeVideo(isNext),
        color: Colors.transparent,
        child: Icon(
          isNext ? Icons.skip_next : Icons.skip_previous,
          size: arentir * 0.12,
          color: Colors.white,
        ),
      );
/*
  void _checkVideo() {
    final value = widget.videoController.value;
    if (value.position == value.duration) {
      _changeVideo(true);
      debugPrint("Video end");
    }
  }*/

  late int index;
  void _changeVideo(bool isNext) {
    index =Provider.of<ProviderVideo>(context, listen: false).obj.index;
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
    _mainBottomSheed();
  }

  /*void _settingModelBottomSheed() {
    final providerF = Provider.of<ProviderFile>(context, listen: false);
    final providerV = Provider.of<ProviderVideo>(context, listen: false);
    providerV.startVideo;
    providerV.changeVideoObj(providerF.videos[index]);
    debugPrint("sheed open!");
  }*/

  void _mainBottomSheed() {
    final providV = Provider.of<ProviderVideo>(context, listen: false);
    final providerF = Provider.of<ProviderFile>(context, listen: false);
    final providC = Provider.of<ControlVideo>(context, listen: false);
    final obj = providerF.videos[index];
     providV.changeShowSheed(false);
    // ControlVideo().dispos;
    //providV.changeShowSheed(false);
    // providC.changeControl(providerF.videos[index].fileController!);
    // providC.clearPrevious;
    providV.changeVideoObj(obj);
  //  providC.changeFileControl(obj.videoFile!);
    // providC.startVideo(() => setState(() => setState(() {})));
    providV.startVideo;
    providV.playerAutoSize;
    providV.resetVolume;
    
    // ControlVideo().startVideo((){});
    providC.nextPlay(obj.videoFile!);

 providV.changeShowSheed(true);
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
                  size: arentir * 0.07,
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
          size: arentir * 0.2,
          color: Colors.white,
        ),
      );

  void tongelePlay() {
    final providerV = Provider.of<ProviderVideo>(context, listen: false);
    final providerC = Provider.of<ControlVideo>(context,listen: false);
    providerV.tonglePause;
    providerV.isVideoPause
        ? providerC.pause
        : providerC.play;
  }

  Widget buildVideoIndicator() => const BasicOverlyWidget();
}
