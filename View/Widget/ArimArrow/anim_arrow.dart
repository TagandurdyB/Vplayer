import 'package:flutter/material.dart';

import 'triengle_painter_widget.dart';

enum Direction { up, down, left, reight }

bool isVetical(Direction direct) {
  if (direct == Direction.up || direct == Direction.down) {
    return true;
  } else {
    return false;
  }
}

bool isReverse(Direction direct) {
  if (direct == Direction.up || direct == Direction.left) {
    return true;
  } else {
    return false;
  }
}

class AnimArrow extends StatefulWidget {
  final Duration duration;
  final Direction direction;
  final String title;
  final double areaRadius;
  final double passivArrowSize;
  final double activArrowSize;
  final double arrowlenght;
  final Color passivArrowColor;
  final Color activArrowColor;
  final int arrowCount;
  final Color areaBackgroundColor;
  const AnimArrow(
      {super.key,
      this.areaRadius = 50,
      this.areaBackgroundColor = Colors.blue,
      this.arrowCount = 3,
      this.passivArrowSize = 20,
      this.activArrowSize = 25,
      this.passivArrowColor = Colors.grey,
      this.activArrowColor = Colors.white,
      this.arrowlenght = 0.6,
      this.direction = Direction.reight,
      this.title = "",
      required this.duration});

  @override
  State<AnimArrow> createState() => _AnimArrowState();
}

class _AnimArrowState extends State<AnimArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController control;
  int activeInd = 0;

  @override
  void initState() {
    super.initState();
    control = AnimationController(vsync: this, duration: widget.duration);

    control.repeat();

    control.addListener(() {
      _animChange();
      setState(() {});
    });
  }

  void _animChange() {
    if (activeInd <= widget.arrowCount && !isReverse(widget.direction)) {
      activeInd = (control.value * widget.arrowCount).round();
    } else if (activeInd <= widget.arrowCount && isReverse(widget.direction)) {
      activeInd =
          (widget.arrowCount - control.value * widget.arrowCount).round();
    } else {
      activeInd = 0;
    }
  }

  @override
  void dispose() {
    control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
                color: widget.areaBackgroundColor,
                shape: BoxShape.circle,
              ),
        //radius: widget.areaRadius,
       
       width: widget.areaRadius,
       height: widget.areaRadius,
       // foregroundColor: widget.areaForegroundColor,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            isVetical(widget.direction)
                ? buildVerticalArriws()
                : buildHorizontalArriws(),
            buildTitle(),
          ],
        ));
  }

  Widget buildHorizontalArriws() => Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: _arrows);

  Widget buildVerticalArriws() => Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: _arrows);

  List<Widget> get _arrows => List.generate(
      widget.arrowCount, ((index) => buildActivPassiv(index == activeInd)));

  Widget buildActivPassiv(bool isActive) => SizedBox(
        height: isActive ? widget.activArrowSize : widget.passivArrowSize,
        width: isActive
            ? widget.activArrowSize * widget.arrowlenght
            : widget.passivArrowSize * widget.arrowlenght,
        child: Trienge(
            direction: widget.direction,
            color: isActive ? widget.activArrowColor : widget.passivArrowColor),
      );

  Widget buildTitle() => Container(
      height: isVetical(widget.direction)
          ? widget.areaRadius
          : widget.areaRadius - widget.activArrowSize,
      alignment: Alignment.topCenter,
      child: Text(widget.title));
}
