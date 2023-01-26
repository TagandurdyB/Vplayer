import 'package:flutter/material.dart';

import '../ViewModel/screen_values.dart';
import '../View/Widget/ArimArrow/anim_arrow.dart';

class AnimArrowPage extends StatefulWidget {
  const AnimArrowPage({super.key});

  @override
  State<AnimArrowPage> createState() => _AnimArrowPageState();
}

class _AnimArrowPageState extends State<AnimArrowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("salam"),
        ),
        body: buildDedector());
  }

  bool isBackward = false;
  bool isForward = false;
  TapDownDetails _doubleTapDetails = TapDownDetails();

  void _handleDoubleTapDown(TapDownDetails details) {
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

  Widget buildDedector() => GestureDetector(
      onDoubleTapDown: _handleDoubleTapDown,
      onDoubleTap: () {
        final int tabX = _getDoubleTapX();
        if (tabX < Screen().width * 0.5) {
          _tabBackward();
        } else {
          _tabForward();
        }
      },
      child: buildScreen());

  Widget buildScreen() => Container(
      color: Colors.black,
      alignment: Alignment.centerLeft,
      width: Screen().width,
      height: Screen().width * 0.6,
      child: buildFastAnims());

  Widget buildFastAnims() => ClipRect(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                left: -100,
                child: Visibility(
                    visible: isBackward, child: buildTextSec(Direction.left))),
            Positioned(
                right: -100,
                child: Visibility(
                    visible: isForward, child: buildTextSec(Direction.reight))),
            Positioned(
                top: -200,
                child: Visibility(
                    visible: true,
                    child: buildFastBtnVertical(Direction.down))),
            Positioned(
                bottom: -200,
                child: Visibility(
                    visible: false, child: buildFastBtnVertical(Direction.up))),
         
          ],
        ),
      );

  Widget buildTextSec(Direction direct) => Stack(
        alignment: Alignment.center,
        children: [
          buildFastBtnHorizontal(direct),
          Positioned(top: Screen().width * 0.3, child: const Text("10 sec"))
        ],
      );

  Widget buildFastBtnHorizontal(Direction direct) => AnimArrow(
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

  Widget buildFastBtnVertical(Direction direct) => AnimArrow(
        mainAxisAlignment:direct==Direction.up?MainAxisAlignment.start:MainAxisAlignment.end,
        arrowPadding: Screen().width*0.1,
        arrowMargim: Screen().width*0.01,
        arrowCount: 5,
        areaRadius: Screen().width,
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
