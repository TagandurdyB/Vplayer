import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_player/Model/video_model.dart';
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

class _MyBottomVideoSheedState extends State<MyBottomVideoSheed>
    with SingleTickerProviderStateMixin {
  double sheedHight = Screen().height;

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
    isFull = Provider.of<ProviderVideo>(context).isFullScreen;
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
            children: [
              buildVideoDrag(),
              buildMinBtns(),
            ],
          ),
          buildSheedList(),
        ],
      ),
    );
  }

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

  Widget buildVideoDrag() => GestureDetector(
      onVerticalDragStart: (detal) {
        dragStartY = detal.globalPosition.dy;
      },
      onVerticalDragUpdate: (detal) {
        dragEndY = detal.globalPosition.dy;
      },
      onVerticalDragEnd: (detal) {
        if (dragEndY - dragStartY > 70) {
          debugPrint(" $dragStartY    $dragEndY  ");
          Provider.of<ProviderVideo>(context, listen: false)
              .changeFullScreen(false);
          setPortrate();
        }
      },
      //    child: PortraitPlayerWidget(obj: widget.obj));
      child: LandscapePlayerWidget(obj: widget.obj));

  void setPortrate() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }

  Widget bulidCloseBtn() => IconButton(
      icon: const Icon(Icons.close, color: Colors.white),
      onPressed: () {
        Provider.of<ProviderVideo>(context, listen: false)
            .changeShowSheed(false);
      });

  Widget buildSheedList() => Visibility(
      visible: isFull,
      child: Flexible(
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
