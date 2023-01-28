import 'package:flutter/material.dart';
import 'package:local_player/View/Widget/bottom_sheed.dart';
import 'package:local_player/ViewModel/Providers/provider_video.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/durations_vm.dart';
import '../../ViewModel/screen_values.dart';

class ViewVideoSheed extends StatefulWidget {
  const ViewVideoSheed({super.key});

  @override
  State<ViewVideoSheed> createState() => _ViewVideoSheedState();
}

class _ViewVideoSheedState extends State<ViewVideoSheed> {
  @override
  Widget build(BuildContext context) {
    final providV = Provider.of<ProviderVideo>(context);
    final bool isShow = providV.isShowSheed;
    final bool isFull = providV.isFullScreen;
    final bool isPortr = providV.isPortrait;
    final size = Screen();
    return GestureDetector(
       onTap: () { 
        final providV=
        Provider.of<ProviderVideo>(context, listen: false);
         providV.changeFullScreen(true);
         providV.playerAutoSize;
         },
      child: AnimatedContainer(
        color: Colors.grey[700],
        duration: MyTimes().timeSheed,
        height: isPortr
            ? isFull
                ? size.height
                : size.playerMinHeight
            : Screen().playerLandscapeHeight,
        width: double.infinity,
        child: Visibility(
            visible: isShow, child: MyBottomVideoSheed(obj: providV.obj)),
      ),
    );
  }
}
