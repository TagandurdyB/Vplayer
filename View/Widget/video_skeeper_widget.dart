import 'package:flutter/material.dart';
import 'package:local_player/View/Widget/ArimArrow/anim_arrow.dart';
import 'package:local_player/ViewModel/Providers/provider_video.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/screen_values.dart';

class VideoSkeeper extends StatefulWidget {
  const VideoSkeeper({super.key});

  @override
  State<VideoSkeeper> createState() => _VideoSkeeperState();
}

class _VideoSkeeperState extends State<VideoSkeeper> {
  late dynamic providerV;
  @override
  Widget build(BuildContext context) {
    providerV = Provider.of<ProviderVideo>(context);
    return buildFastAnims();
  }

  bool isBackward = false;
  bool isForward = false;
  bool isUpward = false;
  bool isDownward = false;
  TapDownDetails _doubleTapDetails = TapDownDetails();

  void handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  int _getDoubleTapX() {
    final position = _doubleTapDetails.globalPosition;
    final int dx = position.dx.round();
    debugPrint('Double tap on position X:=${dx}');
    return dx;
  }

  void _tabBackward() {
    isBackward = true;
    setState(() {});
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      isBackward = false;
      setState(() {});
    });
  }

  void _tabForward() {
    isForward = true;
    setState(() {});
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      isForward = false;
      setState(() {});
    });
  }

  void doubleTab() {
    final int tabX = _getDoubleTapX();
    if (tabX < Screen().width * 0.5) {
      _tabBackward();
    } else {
      _tabForward();
    }
    //  Provider.of<ProviderVideo>(context,listen: false).changa
  }

  Widget buildDedector() => GestureDetector(
      onDoubleTapDown: handleDoubleTapDown,
      onDoubleTap: doubleTab,
      child: buildScreen());

  Widget buildScreen() => Container(
      color: Colors.transparent,
      alignment: Alignment.centerLeft,
      width: Screen().width,
      height: Screen().width * 0.6,
      child: buildFastAnims());

  Widget buildFastAnims() {
    final providerV = Provider.of<ProviderVideo>(context);
    return ClipRect(
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              left: providerV.isPortrait ? -100 : -(Screen().width * 0.7),
              child: Visibility(
                  visible: providerV.isBackward,
                  child: buildTextSec(Direction.left))),
          Positioned(
              right: providerV.isPortrait ? -100 : -(Screen().width * 0.7),
              child: Visibility(
                  visible: providerV.isForward,
                  child: buildTextSec(Direction.reight))),
          Positioned(
              top: providerV.isPortrait ? -200 : -(Screen().width * 1.5),
              child: Visibility(
                  visible: providerV.isDownward,
                  child: buildFastBtnVertical(Direction.down))),
          Positioned(
              bottom: providerV.isPortrait ? -200 : -(Screen().width * 1.5),
              child: Visibility(
                  visible: providerV.isUpward,
                  child: buildFastBtnVertical(Direction.up))),
        ],
      ),
    );
  }

  Widget buildTextSec(Direction direct) => Stack(
        alignment: Alignment.center,
        children: [
          buildFastBtnHorizontal(direct),
          Positioned(
              top: providerV.isPortrait ? Screen().width * 0.3 : null,
              child: const Text("10 sec"))
        ],
      );

  Widget buildFastBtnHorizontal(Direction direct) => AnimArrow(
        mainAxisAlignment: providerV.isPortrait
            ? MainAxisAlignment.center
            : direct == Direction.reight
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
        arrowPadding:
            Provider.of<ProviderVideo>(context, listen: false).isPortrait
                ? Screen().width * 0.1
                : Screen().width * 0.4,
        arrowCount: 3,
        areaRadius:
            providerV.isPortrait ? Screen().width * 0.8 : Screen().width * 1.5,
        arrowlenght: 0.9,
        passivArrowSize: Screen().width * 0.04,
        activArrowSize: Screen().width * 0.045,
        direction: direct,
        areaBackgroundColor: Colors.white60,
        activArrowColor: Colors.white,
        passivArrowColor: Colors.white70,
        duration: const Duration(milliseconds: 300),
      );

  Widget buildFastBtnVertical(Direction direct) => AnimArrow(
        mainAxisAlignment: direct == Direction.up
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        arrowPadding: Screen().width * 0.1,
        arrowMargim: Screen().width * 0.01,
        arrowCount: 5,
        areaRadius: providerV.isPortrait ? Screen().width : Screen().height,
        arrowlenght: 0.9,
        passivArrowSize: Screen().width * 0.04,
        activArrowSize: Screen().width * 0.045,
        direction: direct,
        areaBackgroundColor: Colors.white60,
        activArrowColor: Colors.white,
        passivArrowColor: Colors.white70,
        duration: const Duration(milliseconds: 300),
      );
}
