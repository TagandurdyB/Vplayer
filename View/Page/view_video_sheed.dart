import 'package:flutter/material.dart';
import 'package:local_player/Model/video_model.dart';
import 'package:local_player/View/Widget/bottom_sheed.dart';
import 'package:local_player/ViewModel/Providers/provider_video.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/screen_values.dart';

class ViewVideoSheed extends StatefulWidget {
  final double bodyMaxHeight;
  const ViewVideoSheed({super.key, required this.bodyMaxHeight});

  @override
  State<ViewVideoSheed> createState() => _ViewVideoSheedState();
}

class _ViewVideoSheedState extends State<ViewVideoSheed> {
  double height = 0.0;

  @override
  void initState() {
    super.initState();
    height = widget.bodyMaxHeight;
  }

  void _funcSheedHeight() {
    if (height == Screen().width * 0.25) {
      height = widget.bodyMaxHeight;
    } else {
      height = Screen().width * 0.25;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final providV = Provider.of<ProviderVideo>(context);
    final bool isShow = providV.isShowSheed;
    final bool isFull = providV.isFullScreen;
        final bool isPortr = providV.isPortrait;
    return AnimatedContainer(
      color: Colors.red,
      duration: const Duration(milliseconds: 200),
      height: !isPortr?
       Screen().width
      :
      isShow
          ? isFull
              ? height
              : Screen().width * 0.25
          : 0.0,
      width: double.infinity,
      child: GestureDetector(
          onTap: _funcSheedHeight,
          child:
              isShow ? MyBottomVideoSheed(obj: providV.obj) : const SizedBox()),
    );
  }
}
