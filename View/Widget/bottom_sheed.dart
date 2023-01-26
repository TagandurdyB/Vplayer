import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_player/Model/video_model.dart';
import 'package:local_player/View/Widget/basic_overlay_widget.dart';
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
  late VideoPlayerController videoControl;

  void initState() {
    super.initState();
    videoControl = VideoPlayerController.file(widget.obj.videoFile!)
      ..addListener(() => setState(() {}))
      //   ..setLooping(true)
      ..initialize().then((_) => videoControl.play());
    //setLandscape();
  }

  @override
  void dispose() {
    setPortrate();
    videoControl.dispose();
    super.dispose();
  }

  double dragStartY = 0.0;
  double dragEndY = 0.0;
  double dragStartX = 0.0;
  double dragEndX = 0.0;

  bool isFull = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Provider.of<ProviderVideo>(context, listen: false)
          .changeFullScreen(true),
      child: screenChange(),
    );
  }

  void sheedHeight(double sheedHightDegry) {
    setState(() {
      sheedHight = Screen().height * sheedHightDegry;
    });
  }

  Widget screenChange() {
    final providV = Provider.of<ProviderVideo>(context);
    final bool isPortrait = providV.isPortrait;
    isFull = providV.isFullScreen;
    if (isFull) {
      sheedHeight(1);
    } else {
      sheedHeight(0.1);
    }
    return Container(
      height: sheedHight,
      width: double.infinity,
      color: Colors.grey[700],
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SafeArea(
                child: Row(
                  children: [
                    Expanded(
                        flex: providV.isPortrait ? -1 : 1,
                        child: buildVideoDedector())
                  ],
                ),
              ),
              Positioned.fill(child: buildMinBtns()),
              buildVideoIndicator(),
            ],
          ),
          Visibility(visible: isPortrait, child: buildSheedList()),
        ],
      ),
    );
  }

  Widget buildVideoIndicator() => Visibility(
        visible: !isFull,
        child: Row(
          children: [
            Expanded(
              child: BasicOverlyWidget(
                  videoController: videoControl, allowScrubbing: false),
            ),
          ],
        ),
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
          if(providVget.isFullScreen)
          {providV.changeDragDirection(dragStartY.round(), dragEndY.round());
          providV.dragVertical;
          if (dragEndY - dragStartY > 70) {
            debugPrint(" $dragStartY    $dragEndY  ");
            waiterFunc(doing: () {
              providV.changeFullScreen(!providV.isPortrait);
              providV.changeOrientation(true);
              setPortrate();
            });
          }
          if (dragStartY - dragEndY > 70) {
            debugPrint(" $dragStartY    $dragEndY  ");
            waiterFunc(doing: () {
              //  providV.changeFullScreen(!providV.isPortrait);
              providV.changeOrientation(false);
              setLandscape();
            });
          }}
        },
        onDoubleTapDown: (detail) =>
            providV.changeDoubleTabSide(detail.globalPosition.dx.round()),
        onDoubleTap: () {
          debugPrint("sadjkasjdkj:=${providVget.isFullScreen}");
          if (providVget.isFullScreen) {
            _onDoubleTab(context);
          }
        },
        onTap: () => _showBtns(context),
        //    child: PortraitPlayerWidget(obj: widget.obj));
        child: LandscapePlayerWidget(
            obj: widget.obj, videoController: videoControl));
  }

  void waiterFunc({required Function doing}) {
    Future.delayed(MyTimes().timeArrow).then((_) {
      doing();
    });
  }

  void setPortrate() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }

  void setLandscape() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _onDoubleTab(BuildContext context) =>
      Provider.of<ProviderVideo>(context, listen: false)
          .doubleTab(videoControl);

  void _showBtns(BuildContext context) =>
      Provider.of<ProviderVideo>(context, listen: false).tongleForvardBtns;

  Widget bulidCloseBtn() => IconButton(
      icon: const Icon(Icons.close, color: Colors.white),
      onPressed: () {
        final providV = Provider.of<ProviderVideo>(context, listen: false);
        providV.changeShowSheed(false);
        providV.changeFullScreen(true);
      });

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
