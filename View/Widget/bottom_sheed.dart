import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_player/Model/video_model.dart';
import 'package:local_player/View/Widget/basic_overlay_widget.dart';
import 'package:local_player/ViewModel/Providers/provider_controller.dart';
import 'package:local_player/ViewModel/Providers/provider_orientation.dart';
import 'package:video_player/video_player.dart';
import '../../ViewModel/durations_vm.dart';
import '/ViewModel/Providers/provider_video.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/screen_values.dart';
import 'landscape_player_widget.dart';

class MyBottomVideoSheed extends StatefulWidget {
  final VideoObj obj;
  const MyBottomVideoSheed({super.key, required this.obj});

  @override
  State<MyBottomVideoSheed> createState() => _MyBottomVideoSheedState();
}

class _MyBottomVideoSheedState extends State<MyBottomVideoSheed> {
  double sheedHight = Screen().height;
  // late VideoPlayerController videoControl;
/*
  void initState() {
    super.initState();
    if(widget.obj.videoUrl!=""){
      videoControl = VideoPlayerController.network(widget.obj.videoUrl)
      ..addListener(() => setState(() {}))
      //   ..setLooping(true)
      ..initialize().then((_) => videoControl.play());
    }
    else{
    videoControl = VideoPlayerController.file(widget.obj.videoFile!)
     
      //   ..setLooping(true)
      ..initialize().then((_) => videoControl.play())
       ..addListener(() => setState(() {}))
      ;
    }
    videoControl.setVolume(0.5);
  }

  @override
  void dispose() {
    videoControl.dispose();
    super.dispose();
  }
*/

  @override
  void initState() {
    super.initState();
    /* WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     // Provider.of<ControlVideo>(context,listen: false).startVideo(() => setState(() {}));
    
    });*/
  }

  @override
  void dispose() {
    /* WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     Provider.of<ControlVideo>(context,listen: false).dispos;
    });*/
    ControlVideo().dispos;
    super.dispose();
  }

  double dragStartY = 0.0;
  double dragEndY = 0.0;
  double dragStartX = 0.0;
  double dragEndX = 0.0;

  bool isFull = true;

  @override
  Widget build(BuildContext context) {
    return screenChange();
  }

  Widget screenChange() {
    final providV = Provider.of<ProviderVideo>(context);
    final bool isPortrait = providV.isPortrait;
    isFull = providV.isFullScreen;
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SafeArea(
              child: Row(
                children: [
                  Expanded(
                      flex: isPortrait ? -1 : 1, child: buildVideoDedector())
                ],
              ),
            ),
            Positioned.fill(child: buildMinBtns()),
            buildVideoIndicator(),
          ],
        ),
        Visibility(visible: isPortrait, child: buildSheedList()),
      ],
    );
  }

  Widget buildVideoIndicator() => Visibility(
        visible: !isFull,
        child: const BasicOverlyWidget(allowScrubbing: false),
      );

  Widget buildMinBtns() => Visibility(
        visible: !isFull,
        child: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              bulidCloseBtn(),
            ],
          ),
        ),
      );

  Widget buildVideoDedector() {
    
      Provider.of<ControlVideo>(context).control.addListener(()=>setState((){}));
    final providV = Provider.of<ProviderVideo>(context, listen: false);
    final providVget = Provider.of<ProviderVideo>(context);
    return GestureDetector(
        onVerticalDragStart: (detal) {
          dragStartY = detal.globalPosition.dy;
        },
        onVerticalDragUpdate: (detal) {
          dragEndY = detal.globalPosition.dy;
        },
        onVerticalDragEnd: (detal) {
          if (providVget.isFullScreen) {
            providV.changeDragDirection(dragStartY.round(), dragEndY.round());
            providV.dragVertical;
            if (dragEndY - dragStartY > 70) {
              debugPrint(" $dragStartY    $dragEndY  ");
              waiterFunc(doing: () {
                providV.changeFullScreen(!providV.isPortrait);
                MyOrientation(context).setPortraitUp;
              });
            }
            if (dragStartY - dragEndY > 70) {
              debugPrint(" $dragStartY    $dragEndY  ");
              waiterFunc(doing: () {
                //  providV.changeFullScreen(!providV.isPortrait);
                MyOrientation(context).setLandscape;
              });
            }
          }
        },
        onDoubleTapDown: (detail) =>
            providV.changeDoubleTabSide(detail.globalPosition.dx.round()),
        onDoubleTap: () {
          if (providV.isFullScreen) {
            _onDoubleTab();
          }
        },
        onTap: () => _showBtns(),
        //    child: PortraitPlayerWidget(obj: widget.obj));
        child: LandscapePlayerWidget(obj: widget.obj));
  }

  void waiterFunc({required Function doing}) {
    Future.delayed(MyTimes().timeArrow).then((_) {
      doing();
    });
  }

  void _onDoubleTab() => Provider.of<ProviderVideo>(context, listen: false)
      .doubleTab(Provider.of<ControlVideo>(context,listen: false).control);

  void _showBtns() {
      Provider.of<ProviderVideo>(context, listen: false).tongleForvardBtns;
  }
  Widget bulidCloseBtn() => IconButton(
      icon: const Icon(Icons.close, color: Colors.white),
      onPressed: _closeFunc);

  void _closeFunc() {
    final providV = Provider.of<ProviderVideo>(context, listen: false);
    providV.changeShowSheed(false);
    providV.changeFullScreen(true);
    providV.playerAutoSize;
  }

  Widget buildSheedList() => Visibility(
      visible: isFull,
      child: Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: ((context, index) => Container(
                margin: const EdgeInsets.all(8),
                color: Colors.black,
                width: double.infinity,
                height: 100,
              )),
        ),
      ));
}
