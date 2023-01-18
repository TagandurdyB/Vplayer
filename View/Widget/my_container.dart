import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final double shape;
  final Color? color;
  final List<Color>? colors;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Alignment? alignment;
  final Alignment? gradientBegin;
  final Alignment? gradientEnd;
  final Function? onTap;
  const MyContainer(
      {super.key,
      this.child,
      this.width,
      this.height,
      this.shape = 0.0,
      this.color = Colors.grey,
      this.colors,
      this.padding,
      this.margin,
      this.alignment,
      this.gradientBegin,
      this.gradientEnd,
      @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: Container(
        padding: padding,
        margin: margin,
        alignment: alignment,
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: colors == null ? color : null,
            borderRadius: BorderRadiusDirectional.circular(shape),
            gradient: colors != null
                ? LinearGradient(
                    begin: gradientBegin ?? Alignment.topLeft,
                    end: gradientEnd ?? Alignment.bottomRight,
                    colors: colors ?? [Colors.blue, Colors.red])
                : null),
        child: child,
      ),
    );
  }
}
