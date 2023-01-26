import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/Providers/provider_video.dart';
import 'landscape_player_widget.dart';
/*
// ignore: must_be_immutable
class PlayerBox extends StatelessWidget {
  PlayerBox({super.key});

  double dragStartY = 0.0;
  double dragEndY = 0.0;

  bool isFull = true;

  late BuildContext contextM;

  @override
  Widget build(BuildContext context) {
    contextM = context;
    return buildVideoDrag();
  }

  Widget buildVideoDrag() {
    final providV = Provider.of<ProviderVideo>(contextM, listen: false);
    return GestureDetector(
        onVerticalDragStart: (detal) {
          dragStartY = detal.globalPosition.dy;
        },
        onVerticalDragUpdate: (detal) {
          dragEndY = detal.globalPosition.dy;
        },
        onVerticalDragEnd: (detal) {
          if (dragEndY - dragStartY > 70) {
            debugPrint(" $dragStartY    $dragEndY  ");
            providV.changeFullScreen(false);
            providV.changeOrientation(true);
            setPortrate();
          }
        },
        //    child: PortraitPlayerWidget(obj: widget.obj));
        child: LandscapePlayerWidget(obj: providV.obj));
  }
}

void setPortrate() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
}
*/