import 'package:flutter/material.dart';

import '../../ViewModel/screen_values.dart';
import '../Widget/ArimArrow/anim_arrow.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
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
          ],
        ),
      );

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
