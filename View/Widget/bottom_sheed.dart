import 'package:flutter/material.dart';
import 'package:local_player/Model/video_model.dart';
import 'package:local_player/View/Widget/video_play_file_widget.dart';

import '/View/Widget/video_play_asset_widget.dart';
import '/ViewModel/Providers/provider_video.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/screen_values.dart';

class MyBottomSheed extends StatefulWidget {
  final VideoObj obj;
  const MyBottomSheed({super.key, required this.obj});

  @override
  State<MyBottomSheed> createState() => _MyBottomSheedState();
}

class _MyBottomSheedState extends State<MyBottomSheed>
    with SingleTickerProviderStateMixin {
  late AnimationController animControler;

  double sheedHight = Screen().height;

  double dragStartY = 0.0;
  double dragEndY = 0.0;

  @override
  void initState() {
    super.initState();
    animControler = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Provider.of<ProviderVideo>(context, listen: false)
          .changeFullScreen(true),
      child: screenChange(),
    );
  }

  Widget screenChange() {
    bool isFull = Provider.of<ProviderVideo>(context).isFullScreen;
    final screen = Screen();
    if (isFull) {
      debugPrint("sheed Full!");
      animControler.forward();
      animControler.addListener(() {
        setState(() {
          sheedHight = screen.height * animControler.value;
        });
        debugPrint("sheedHight:=$sheedHight");
      });
    } else {
      debugPrint("sheed unFull!");
      animControler.reverse();
      animControler.addListener(() {
        setState(() {
          sheedHight = screen.height * (animControler.value + 0.1);
        });
      });
    }
    return Container(
      height: sheedHight,
      color: Colors.blue,
      child: Stack(
        children: [
          buildVideoDrag(),
          Visibility(
            visible: !isFull,
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          /*Visibility(
              visible: isFull,
              child: Flexible(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: ((context, index) => Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        color: Colors.orange,
                        width: double.infinity,
                        height: 100,
                      )),
                ),
              ))*/
        ],
      ),
    );

    /*  return Container(
      height: sheedHight,
      width: double.infinity,
      color: Colors.blue,
      child: Stack(
        children: [
          buildVideoDrag(),
        ],
      ),
    );*/
  }

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
        }
      },
      //child: VideoPlayerFileWidget(videoFile: widget.obj.videoFile!));
      child: VideoPlayerFileWidget(videoFile: widget.obj.videoFile!));
  /* child: Container(
        height: 150,
        width: 200,
        color: Colors.red,
      ));*/
}
