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
  @override
  Widget build(BuildContext context) => buildFastAnims();
  

  bool isBackward = false;
  bool isForward = false;
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

void doubleTab(){
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

  Widget buildFastAnims()  {
    final providerV=Provider.of<ProviderVideo>(context);
    return ClipRect(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                left: -100,
                child: Visibility(
                    visible: providerV.isBackward, child: buildTextSec(Direction.left))),
            Positioned(
                right: -100,
                child: Visibility(
                    visible: providerV.isForward, child: buildTextSec(Direction.reight))),
          ],
        ),
      );}

  Widget buildTextSec(Direction direct) => Stack(
        alignment: Alignment.center,
        children: [
          buildFastBtn(direct),
          Positioned(top: Screen().width * 0.3, child: const Text("10 sec"))
        ],
      );

  Widget buildFastBtn(Direction direct) => AnimArrow(
        arrowCount: 3,
        areaRadius: Screen().width * 0.8,
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